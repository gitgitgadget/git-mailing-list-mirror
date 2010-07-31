From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: noob user, want checkins to all be forced to LF terminated
 lines
Date: Fri, 30 Jul 2010 23:49:57 -0500
Message-ID: <20100731044957.GA8920@burratino>
References: <i308gl$v6p$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Walter Bright <boost@digitalmars.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 06:51:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of42W-000382-IK
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 06:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494Ab0GaEvL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 00:51:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40932 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab0GaEvK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 00:51:10 -0400
Received: by iwn7 with SMTP id 7so2005728iwn.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 21:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=pWoydnUD4ST+KqhTw42bsVK9wAAZSkHV0zHDwOJhTug=;
        b=o+Gxw4HGBQlv14yWn8uvee7SngYdJdcl6L1afRntZa6L8/eAJSswnGf730oZgDwcgz
         nCkAHUQdTOaWjxOqFzR7MvbWqgPCWb24+/bYZH1bs/z4eO+nUc9RCFJRiCQnuX0Qcd7p
         iahLuwnkZFP3UFTB+j3ohztRpZ6JtM0rYR+1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Bg3cfOw4LHo6JX9xcENpgDGanu4EMDocjFicyUcAuL9t0v+ESJwwBwe8pwxOpfkUeZ
         ToGqkiSkCEw4Qj6hDSIBeaKR/6PF2e7YitbriCxczOKQozYlDcXUxIAmZSol9tUWAKKN
         27cb7bFuLvtAVBSPtIqL5KheCYJtyACnmW3OY=
Received: by 10.231.32.69 with SMTP id b5mr2950712ibd.153.1280551869240;
        Fri, 30 Jul 2010 21:51:09 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n20sm2648687ibe.23.2010.07.30.21.51.08
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 21:51:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <i308gl$v6p$1@dough.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152301>

Walter Bright wrote:

> I've just started with git.

I thought I saw you here years ago. :)

> Exactly what do I put in $HOME/.gitconfig ?

Well, naturally it depends on what you want to happen.

If you just want to make sure any new files you commit are tracked
with simple LF line endings, you can use

	[core]
		autocrlf =3D input

With this setting, Git will not do any munging to files in the work
tree in any way (unless there is a .gitattributes file requesting to
do so).

That is an _altruistic_ setting to use.  It ensures you do not pollute
history with some alternative line-ending, but your own work tree may
not necessarily match the cleaned up versions you are checking in; so
if you try to "git add" and then "touch" a file with CRLF line endings
with this setting enabled, you may be surprised at the result!
(Though a simple "git checkout file.c" afterwards should fix up the
line endings in the work tree.)

If you want to make sure text files in the work tree use LF line
endings and you are using a recent version of Git, use the above
setting or

	[core]
		eol =3D lf

On Unix-y systems, you do not have to do that, since it is the
default.  On Windows, the "[core] autocrlf" setting is set up
by default in /etc/gitconfig so you would probably want to
override that with

	[core]
		autocrlf =3D false

if you are not setting it to input.

Which files are text files? you may ask.  By default (unless
autocrlf is enabled), Git treats files as raw data; to get it
to futz with line endings, you have to declare your text files
in a file named .gitattributes in the tracked tree.

	* crlf
	*.jpg -crlf
	*.png -crlf

The keyword crlf here means =E2=80=9Capply line-ending conversions=E2=80=
=9D and
nothing more.  In particular, it does not represent the preferred
line ending.

If everyone for which you want these setting to take effect uses a
recent version of git, you can write =E2=80=9Ctext=E2=80=9D instead of =
=E2=80=9Ccrlf=E2=80=9D if
you prefer.

Hope that helps,
Jonathan
