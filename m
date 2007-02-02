From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] fix some doc typos and grammar
Date: Fri, 02 Feb 2007 12:28:19 +0100
Organization: At home
Message-ID: <epv761$gc1$1@sea.gmane.org>
References: <3c6c07c20702012225v19b7aa66vc98a028f700914db@mail.gmail.com> <7vmz3xjbxv.fsf@assigned-by-dhcp.cox.net> <3c6c07c20702012326h551b9f32gb3d8238361105741@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 02 12:28:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCwaR-0002Un-9C
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 12:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbXBBL2I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 06:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbXBBL2H
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 06:28:07 -0500
Received: from main.gmane.org ([80.91.229.2]:55146 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbXBBL2G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 06:28:06 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCwa5-0002Pk-KV
	for git@vger.kernel.org; Fri, 02 Feb 2007 12:27:53 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 12:27:49 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 12:27:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38492>

Mike Coleman wrote:
> On 2/2/07, Junio C Hamano <junkio@cox.net> wrote:

>> It is usually nicer to put this "cover letter" material below
>> the three dashes after Signed-off-by line; not a huge deal,
>> though.
> 
> I remembered that the three dashes mattered, but I couldn't remember
> if it was above or below.
> 
> It turns out that it's fairly easy to configure gmail to accept an
> SMTP connection.  This recipe shows how to configure ssmtp, which is
> just a really dumb sender, to work with gmail:
> 
>     http://www.destr0yr.com/article.php/Gmail_and_sSMTP
> 
> This makes git-send-email work directly, and avoids the gmail web MUA.

It is fairly easy to do the same with sendmail (which is default MTA
for many Linux distributions). I have googled the answer thanks to
some tips on #git channel. You have to change /etc/mail/sendmail.mc
(or the file where SMART_HOST is commented out), add your credentials
to /etc/mail/authinfo, then compile changes using "make -C /etc/mail"
(all of it as root, I think).

Your credential should have the form (in /etc/mail/authinfo)

  AuthInfo:smtp.gmail.com "U:username@gmail.com" "P:password" "M:PLAIN"
  AuthInfo: "U:username@gmail.com" "P:password" "M:PLAIN"

You can store password base64 encoded by using "P=base64pass" instead.
/etc/mail/authinfo should be readable only by sendmail.

Below here are changes I have made in diff form. Most probably only
the first chunk is needed; correct me if I'm wrong, please

--- /etc/mail/sendmail.mc.orig  2005-05-06 14:35:09.000000000 +0200
+++ /etc/mail/sendmail.mc       2006-11-25 17:20:50.000000000 +0100
@@ -19,7 +19,7 @@
 dnl # Uncomment and edit the following line if your outgoing mail needs to
 dnl # be sent out through an external mail server:
 dnl #
-dnl define(`SMART_HOST',`smtp.your.provider')
+define(`SMART_HOST',`[smtp.gmail.com]')
 dnl #
 define(`confDEF_USER_ID',``8:12'')dnl
 dnl define(`confAUTO_REBUILD')dnl
@@ -37,7 +37,7 @@
 dnl # The following allows relaying if the user authenticates, and disallows
 dnl # plaintext authentication (PLAIN/LOGIN) on non-TLS links
 dnl #
-dnl define(`confAUTH_OPTIONS', `A p')dnl
+define(`confAUTH_OPTIONS', `A p')dnl
 dnl # 
 dnl # PLAIN is the preferred plaintext authentication method and used by
 dnl # Mozilla Mail and Evolution, though Outlook Express and other MUAs do
@@ -45,8 +45,8 @@
 dnl # guaranteed secure.
 dnl # Please remember that saslauthd needs to be running for AUTH. 
 dnl #
-dnl TRUST_AUTH_MECH(`EXTERNAL DIGEST-MD5 CRAM-MD5 LOGIN PLAIN')dnl
-dnl define(`confAUTH_MECHANISMS', `EXTERNAL GSSAPI DIGEST-MD5 CRAM-MD5 LOGIN PLAIN')dnl
+TRUST_AUTH_MECH(`EXTERNAL DIGEST-MD5 CRAM-MD5 LOGIN PLAIN')dnl
+define(`confAUTH_MECHANISMS', `EXTERNAL GSSAPI DIGEST-MD5 CRAM-MD5 LOGIN PLAIN')dnl
 dnl #
 dnl # Rudimentary information on creating certificates for sendmail TLS:
 dnl #     cd /usr/share/ssl/certs; make sendmail.pem
@@ -71,6 +71,7 @@
 dnl FEATURE(delay_checks)dnl
 FEATURE(`no_default_msa',`dnl')dnl
 FEATURE(`smrsh',`/usr/sbin/smrsh')dnl
+FEATURE(`authinfo',`hash -o /etc/mail/authinfo.db')dnl
 FEATURE(`mailertable',`hash -o /etc/mail/mailertable.db')dnl
 FEATURE(`virtusertable',`hash -o /etc/mail/virtusertable.db')dnl
 FEATURE(redirect)dnl
@@ -153,7 +154,7 @@
 dnl # The following example makes mail from this host and any additional
 dnl # specified domains appear to be sent from mydomain.com
 dnl #
-dnl MASQUERADE_AS(`mydomain.com')dnl
+MASQUERADE_AS(`gmail.com')dnl
 dnl #
 dnl # masquerade not just the headers, but the envelope as well
 dnl #

Perhaps we should have put those on GitWiki page. Any volunteers?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
