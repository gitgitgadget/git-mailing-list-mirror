From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Why is "git tag --contains" so slow?
Date: Wed, 30 Jun 2010 21:00:21 -0400
Message-ID: <AANLkTikkLIKm3soF9agXnN34P7Xnq4AiVqGU_qFaaRmZ@mail.gmail.com>
References: <E1OU82h-0001xY-3b@closure.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jul 01 03:00:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OU891-0001jP-EA
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 03:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624Ab0GABAm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jun 2010 21:00:42 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47216 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab0GABAm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jun 2010 21:00:42 -0400
Received: by gwb15 with SMTP id 15so786321gwb.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 18:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=370Fov3QBiaBlyFDjMabkxf/m3LVMcntybUG/c/OFHo=;
        b=IodY4JHMWs5pFZUxtXoDjodjApOA5KYoXgN8FGP8BhIxtxLKmgkNFK0fJ3nmecAPgH
         xjE8KOFELQPwkhPFBVywzRYAAxFJrnQdF0TTxNFQb3TeoFVnW4AHPBqIxs+4sTyjW4/l
         AJek9YZP/PC4iYZAazF3LOqyA0XbioL8Vg+fk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sDEGetdMm5gjLbNc/OE3xBxT1wEAlaPkp03SWJqdI7BCamby5wRT+WcooZbyRZFV0Q
         KCqdpab/Iev+HAGlFL0kmGEnNlqx9wkFPA0eaQVvKtNFbzniSNcnGqmCbnJVuNmixGkX
         ED2e/Fpk2bJiQE/PqNZzJ8EciTQdy9MhTHMIE=
Received: by 10.100.208.10 with SMTP id f10mr11772193ang.135.1277946041221; 
	Wed, 30 Jun 2010 18:00:41 -0700 (PDT)
Received: by 10.151.45.4 with HTTP; Wed, 30 Jun 2010 18:00:21 -0700 (PDT)
In-Reply-To: <E1OU82h-0001xY-3b@closure.thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150004>

On Wed, Jun 30, 2010 at 8:54 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> I'm trying to write a script that can determine the first kernel rele=
ase
> (i.e., a tag of that matchs v2.6.*) that contains a particular commit=
=2E
>
> I can do this using "git tag --contains <commit-id>", but it's quite
> slow. =A0It takes something like 8-9 seconds. =A0(8.5 seconds of user=
 time,
> 8.6 times of wall clock, to be precise).
>
> I can get the information much faster using "gitk -1 <commit-id>", wh=
ich
> finishes painting the screen in under 2 seconds, but that throws up a
> GUI and then a human has to pull the information out using their eyes=
=2E

There's a big difference between the two: the gitk command you're
using only works if the given commit is *itself* named by a tag, while
'git tag --contains' needs to search the entire history of every tag
to see if the given commit is *inside* it somewhere.

If all you want is to see if a given commit exactly matches a tag,
perhaps you want something like

   git describe --exact-match <commit-id>

Have fun,

Avery
