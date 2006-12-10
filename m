X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file permission bits)
Date: Sun, 10 Dec 2006 19:26:32 +0100
Message-ID: <200612101926.33307.jnareb@gmail.com>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com> <elh91b$v6r$1@sea.gmane.org> <A52817B6-0265-4164-8E5D-334AF92DC267@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 10 Dec 2006 18:24:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ce1fny0L1jgcOD0lTjgzZPZzZurmCoQhCggIWzS/Lo/bC+nav1utjBGSnvupEkA0DW7n1EoBP7ERuC+OqSO9Hn3KxEYUAvINPn+LEQbS+Msjj7dsTkRCfR1ubpue5gdlYptYfQCoMDSm6RBHD01DJFUR/1822VLbci4hm62x7lc=
User-Agent: KMail/1.9.3
In-Reply-To: <A52817B6-0265-4164-8E5D-334AF92DC267@mac.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33913>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtTLm-0002NI-NY for gcvg-git@gmane.org; Sun, 10 Dec
 2006 19:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762335AbWLJSYU convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006 13:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762334AbWLJSYU
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 13:24:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:6501 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762332AbWLJSYU (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 13:24:20 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1136629uga for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 10:24:18 -0800 (PST)
Received: by 10.66.255.7 with SMTP id c7mr8599374ugi.1165775058436; Sun, 10
 Dec 2006 10:24:18 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id 24sm6016777ugf.2006.12.10.10.24.17; Sun, 10 Dec
 2006 10:24:18 -0800 (PST)
To: Kyle Moffett <mrmacman_g4@mac.com>
Sender: git-owner@vger.kernel.org

Kyle Moffett wrote:
> On Dec 10, 2006, at 10:30:00, Jakub Narebski wrote:
>> Jeff Garzik wrote:
>>>
>>> I actively use git to version, store and distribute an exim mail =A0
>>> configuration across six servers. =A0So far my solution has been a =
=A0
>>> 'fix perms' script, or using the file perm checking capabilities =A0
>>> of cfengine.
>>
>> Fix perms' script used on a checkout hook is a best idea I think.
>=20
> Hmm, unfortunately that has problems with security-related race =A0
> conditions when used directly for /etc. =A0Think about what happens =A0
> with "/etc/shadow" in that case, for example. =A0(/etc/.git is of =A0
> course 0700) =A0I'm sure there are others where non-root daemons get =
=A0
> unhappy when they get an inotify event and their config files have =A0
> suddenly become root:root:0600. =A0I also want to be able to "cd /etc=
 =A0
> && git status" to see what changed after running "apt-get update" or =
=A0
> maybe fiddling in SWAT or webmin, so a makefile which installs into /=
=20
> etc won't quite solve it either. =A0It would also be nice to see when=
 =A0
> things change the permissions on files in /etc, or even bind-mount an=
 =A0
> append-only volume over /etc/.git/objects to provide additional data =
=A0
> security.

The idea is to not store /etc in git directly, but use import/export
scripts, which for example saves permissions and ownership in some
file also tracked by git on import, and restores correct permissions
on export. That is what I remember from this discussion. This of course
means that you would have to write your own porcelain...

What about mentioned in other email IsiSetup?

--=20
Jakub Narebski
Warsaw, Poland
