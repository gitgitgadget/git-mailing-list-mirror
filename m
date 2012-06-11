From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: How can I specify the "sendmail" program for git-send-email?
Date: Mon, 11 Jun 2012 11:15:02 +0200
Message-ID: <CABPQNSZ1dyAfCVLGcLxbeBdS_9A_arYOhzgKBtndReK5zxu_MA@mail.gmail.com>
References: <20120611073232.GA5602@richard> <CABPQNSbwtP0hp8QYznwXjLAaoKVj_ZUWXQQCDG80Xb+TME1MWw@mail.gmail.com>
 <20120611090431.GA23447@richard>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Richard Yang <weiyang@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 11:15:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se0iz-0007Oq-Gb
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 11:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149Ab2FKJPo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 05:15:44 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:33168 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128Ab2FKJPn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 05:15:43 -0400
Received: by gglu4 with SMTP id u4so2316988ggl.19
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 02:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=D9L+RbhM/uqn4Y/CoIMMsQxksRks2A+XVzVfMK2fz6M=;
        b=BTxSqVNrD6+BSk0qyWIWaO6nUeceqMW/BQ3l6xxidAvfLgd7dHYW989EiwzKK0O+uF
         Vry8w/jZ4wnbMI121xE3VmYOQwyvkrprobvjp4qNR+8Nc3n3HQzA/HayTuj52dQMo1Yh
         idblmvQCw70FXVJI4jdBk46u07eIsZ/Q2kgF1APlNUgWPLHU1ofYr8eGSmTofP1yp8Ct
         qPbUO+b7ksq7CXa3WFp4bkCcmyqfUdWbpG0+wrC744OSJT+HD5cYxPYtuo82yRnE0shG
         gbD462wPXvHXyIKKY1qvvIOqXQtTliJhdwykxNgZoE5C5asc6AKIVbM8cTkDpusxO55H
         6IUQ==
Received: by 10.50.156.234 with SMTP id wh10mr5794235igb.20.1339406142642;
 Mon, 11 Jun 2012 02:15:42 -0700 (PDT)
Received: by 10.231.108.201 with HTTP; Mon, 11 Jun 2012 02:15:02 -0700 (PDT)
In-Reply-To: <20120611090431.GA23447@richard>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199634>

On Mon, Jun 11, 2012 at 11:04 AM, Richard Yang
<weiyang@linux.vnet.ibm.com> wrote:
> On Mon, Jun 11, 2012 at 10:23:21AM +0200, Erik Faye-Lund wrote:
>>On Mon, Jun 11, 2012 at 9:32 AM, Richard Yang
>><weiyang@linux.vnet.ibm.com> wrote:
>>> Hi, experts
>>>
>>> I read the git-send-email manual and find the --smtp-server option =
can
>>> specify the sendmail-like program to send mail.
>>>
>>> Then I use this option in command line
>>> --smtp-server=3D/usr/bin/msmtp
>>> This works.
>>>
>>> While I found it not very convenient to write the option on command=
 line
>>> every time, then I wrote it in the .gitconfig file in my home direc=
tory.
>>>
>>> [sendmail]
>>> =A0 =A0 =A0 =A0smtpserver =3D /usr/bin/msmtp
>>> =A0 =A0 =A0 =A0smtppass =A0 =A0 =A0 =3D 123456
>>> =A0 =A0 =A0 =A0smtpuser =A0 =A0 =A0 =3D weiyang@linux.vnet.ibm.com
>>> =A0 =A0 =A0 =A0smtpserverport =3D 143
>>
>>The configuration-section for git send-mail is actually spelled
>>"sendemail", and not "sendmail". Notice the additional 'e'.
> Oops, a stupid mistake.
>
> Thanks all :)

Well, I've always been slightly annoyed by the "send-mail" vs
"sendemail" inconsistency. Perhaps we could do something along these
lines (plus all documentation-updates, omitted for clarity) to reduce
the risk of confusion?

Yeah, the leaking of $identity between different sections is a bit
suboptimal, but as a fallback-mechanism I don't think it actually
matters much.

diff --git a/git-send-email.perl b/git-send-email.perl
index 03292fd..d167d96 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -375,7 +375,11 @@ sub read_config {
 	}
 }

-# read configuration from [sendemail "$identity"], fall back on [sende=
mail]
+# read configuration from [sendmail "$identity"], fall back on [sendma=
il]
+$identity =3D Git::config(@repo, "sendmail.identity") unless (defined =
$identity);
+read_config("sendmail.$identity") if (defined $identity);
+read_config("sendmail");
+# same as above, but with legacy "sendemail"
 $identity =3D Git::config(@repo, "sendemail.identity") unless (defined
$identity);
 read_config("sendemail.$identity") if (defined $identity);
 read_config("sendemail");
