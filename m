From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] gitweb: fix esc_param
Date: Tue, 13 Oct 2009 23:29:45 -0700
Message-ID: <4AD56FD9.70602@gmail.com>
References: <1255463496-21617-1-git-send-email-giuseppe.bilotta@gmail.com> 	<4AD525CA.8090102@gmail.com> <cb7bb73a0910132319p27b4f362sf5bffa2afe6e5849@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 08:34:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxxRO-000452-V9
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 08:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755376AbZJNGa1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 02:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755186AbZJNGa1
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 02:30:27 -0400
Received: from mail-qy0-f186.google.com ([209.85.221.186]:61499 "EHLO
	mail-qy0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755363AbZJNGaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 02:30:25 -0400
Received: by qyk16 with SMTP id 16so3889684qyk.15
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 23:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=grhnaW44ctP8XwwNsSIp2/ZuGGKuVgtbZbn3dig52wA=;
        b=b5RmlSeVeEHlWuSuenoiMSGQmTmEsU1wNoAsr0E1dMLfFoWRKrksyTM0s0TOow74nY
         HQQ8r9XFnXDb4b1gG4dVTWHOZKdgo7C/cBQSck7bF5rywG0DiqveCBPCc/52HmJLvWOl
         sJ0fBqQ173F5mVOxWpOfemhSyDaQYqtkgfPlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=JEE22GORssQE+M8d3aMQMaB7RB7Sgt/GBu0/anUoQpieqzY9jz4miZN0QZfRpgym+3
         Y+RzMePwsbX5JDZZCpXiUgs47nIEhbGtGTHEXvvM3MTT8N7Fb8oOf/87HKbtflaVFhp+
         seMo8Dek2ygec9nuA4vRlItXo9NEWwx3OIRiI=
Received: by 10.224.83.136 with SMTP id f8mr6755849qal.86.1255501789363;
        Tue, 13 Oct 2009 23:29:49 -0700 (PDT)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 7sm835132qwb.22.2009.10.13.23.29.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Oct 2009 23:29:48 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090827)
In-Reply-To: <cb7bb73a0910132319p27b4f362sf5bffa2afe6e5849@mail.gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130258>

Giuseppe Bilotta wrote:
> On Wed, Oct 14, 2009 at 3:13 AM, Stephen Boyd <bebarino@gmail.com> wr=
ote:
>> This works great for my purposes. Thanks.
>
> Can you also check if this fixes the branch name issue you mentioned
> in the other branch? (And/or do you have a repository exposing the
> problem if not?)

(We're jumping back and forth between threads haha)

Sorry, it doesn't. But this diff fixes the first part of the problem.
There are still problems with the RSS/Atom feed names being mangled. Th=
e
branch name I'm using is gitw=E9b, but I imagine any utf8 character wil=
l fail.

I see the title and the actual text being mangled without this patch.

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4b21ad2..910c370 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1500,9 +1500,10 @@ sub format_ref_marker {
                                -href =3D> href(
                                        action=3D>$dest_action,
                                        hash=3D>$dest
-                               )}, $name);
+                               )}, esc_html($name));
=20
-                       $markers .=3D " <span class=3D\"$class\" title=3D=
\"$ref\">" .
+                       my $title_ref =3D esc_html($ref);
+                       $markers .=3D " <span class=3D\"$class\" title=3D=
\"$title_ref\">" .
                                $link . "</span>";
                }
        }
