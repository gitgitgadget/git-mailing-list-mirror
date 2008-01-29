From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Added sub get_owner_file which checks if there's a file with project owner name
Date: Tue, 29 Jan 2008 22:36:18 +0100
Message-ID: <200801292236.19630.jnareb@gmail.com>
References: <1201577766-11601-1-git-send-email-ribas@c3sl.ufpr.br> <200801291628.21026.jnareb@gmail.com> <479F925A.5020401@iksz.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: Nagy =?utf-8?q?Bal=C3=A1zs?= <js@iksz.hu>
X-From: git-owner@vger.kernel.org Tue Jan 29 22:37:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJy9E-0002g3-LT
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 22:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758617AbYA2Vga convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2008 16:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758601AbYA2Vga
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 16:36:30 -0500
Received: from mu-out-0910.google.com ([209.85.134.187]:8188 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758521AbYA2Vg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 16:36:28 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1768708mue.5
        for <git@vger.kernel.org>; Tue, 29 Jan 2008 13:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=sxONvjCZkwJ4e1hHZXJu6sCoDWXROcvhojSBerOO7yo=;
        b=hS1U15k9NkT+V7KccfZMH5DxNr3BjErLTfU33roQMOU/h8UwTVrA8SqqdsQkKvONDSXjLo5SssI352nyD2CwRovZhDdCFFG0XEoSVpS8NcYUQ4PY+rj17MlAhMtEt8DiRB0KN1feulJJYxHQrFaKtHudx3W2XLVarlqcbOIDXbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=l6D6xcRGfgv/WAhObCz0JrTRaNFKIivb9I4kpccXOPwi8d4K4U3xJQ01hejzX3LOicPKS3OM+5pkP1rdOrbgyYKWOnA5Ck7AZT3bNclkRLk5kUmlgTX9VWTp58FqimYIeJo1ae3pJEbAJTAN7EZGv5Ni5iwHAlAYskYM7L4JbCc=
Received: by 10.78.138.6 with SMTP id l6mr10418711hud.32.1201642587127;
        Tue, 29 Jan 2008 13:36:27 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.244.23])
        by mx.google.com with ESMTPS id d25sm17122512nfh.33.2008.01.29.13.36.24
        (version=SSLv3 cipher=OTHER);
        Tue, 29 Jan 2008 13:36:26 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <479F925A.5020401@iksz.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71999>

Nagy Bal=C3=A1zs wrote:
> Jakub Narebski wrote:

>> But I think if IO matters it is better to generate projects list; yo=
u
>> can even use gitweb for that, or you can simply add a line with URL
>> escaped project name (project path) relative to $projectroot, separa=
ted
>> by space from the URL escaped (URI-encoded) project owner.  See also
>> "Gitweb repositories" section in gitweb/INSTALL.  Adding projects is
>> rare event.
>>  =20
> Are you talking about I/O of an all-in CGI script? =20

I am talking there between I/O difference between situation
(configuration) when $projects_list is a directory (default),
or is a file. If $projects_list is a directory, gitweb scans
directory structure to find git repositories, which for large
number of repositories might take time, even with filesystem
cache, and with depth of searching bound by $project_maxdepth.
Add to that finding symbolic name of the owner of repository
directory, or (with the patch) reading a file per repo with repo
owner.

Reading and pasing single text file avoids this; it is faster.
But for small repos it is easier to scan directory, and difference
in performance is not much.

> We can tune the =20
> performance of this script, but changing the GIT_DIR structure just=20
> because of a simple script is a bit overkill to me.
>=20
> What if this script creates the $projects_list file, for example when=
=20
> the $projectroot's mtime changes?  We can even hold mtime info for ev=
ery=20
> project's config file.

I don't understand what you wanted to say here. $projects_list file
lists only project path (project name) and project owner.

--=20
Jakub Narebski
Poland
