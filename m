From: Patrick Palka <patrick@parcs.ath.cx>
Subject: Re: [PATCH] Improve contrib/diff-highlight to highlight unevenly-sized
 hunks
Date: Thu, 18 Jun 2015 19:06:02 -0400 (EDT)
Message-ID: <alpine.DEB.2.20.8.1506181845310.4322@idea>
References: <1434388853-23915-1-git-send-email-patrick@parcs.ath.cx> <xmqqwpz1f22b.fsf@gitster.dls.corp.google.com> <CA+C-WL-CC9o13Rxrr+mKw+vbx=aEJmguLnwMwO=fE-JPJ2DqEg@mail.gmail.com> <xmqq1th8ga9b.fsf@gitster.dls.corp.google.com> <20150618190417.GA12769@peff.net>
 <alpine.DEB.2.20.8.1506181536070.4322@idea> <20150618204505.GD14550@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: Patrick Palka <patrick@parcs.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 19 01:06:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5isu-0007Ip-Gg
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 01:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbbFRXGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 19:06:07 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35544 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbbFRXGF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 19:06:05 -0400
Received: by qgeu36 with SMTP id u36so31288191qge.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 16:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=gxB/MwiJ29KxtX1vt9hEEWL6b8ugrRtVaxSSObzyou4=;
        b=ZR8ErIEsnPLqog2moZIEQTYi6164ZrKIqeVkKl1lJ9PH802wlkMOvWcysZ3eaqbTFU
         hYud0QvuoM0KZYgTe2zKlTndG247HOQO6H+MLPbH4ky0JZZe7Rt5VF7Vf9erA5KMyfHC
         EAA7Sc1XKU6vBee50uP8o9el5uEGdYTD9Ekh06ZfMOnBmhySNFMuV4V9iwb85WmCzvuw
         dwJL2aOXhakROvRPMt0dZNDTvWGIwjsFVuj4X0xl+1Uek4LYT+PP34f7MGtXQqp5SkqM
         t7Mtm93MBS9UmsM4EslwAeaiEob6UbWZdzQSzKwGH7GGysS7sFq7o6vYxU63WpllF4Fp
         68Qg==
X-Gm-Message-State: ALoCoQmR90B3rmEDK2kwYr4+pP18/PGEwyRw9HCRyF8DAv3TcRQbPiXg6EgBpgfKjKeSjcLME1Mq
X-Received: by 10.55.22.130 with SMTP id 2mr29905700qkw.45.1434668764228;
        Thu, 18 Jun 2015 16:06:04 -0700 (PDT)
Received: from [192.168.1.130] (ool-4353acd8.dyn.optonline.net. [67.83.172.216])
        by mx.google.com with ESMTPSA id q74sm4659954qha.4.2015.06.18.16.06.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2015 16:06:03 -0700 (PDT)
X-Google-Original-From: Patrick Palka <patrick@idea>
In-Reply-To: <20150618204505.GD14550@peff.net>
User-Agent: Alpine 2.20.8 (DEB 77 2015-05-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272095>

On Thu, 18 Jun 2015, Jeff King wrote:

> On Thu, Jun 18, 2015 at 04:14:19PM -0400, Patrick Palka wrote:
>
>>> in a test script becomes more clear. But some of the output is not so
>>> great. For instance, the very commit under discussion has a
>>> confusing and useless highlight. Or take a documentation patch like
>>> 5c31acfb, where I find the highlights actively distracting. We are saved
>>> a little by the "if the whole line is different, do not highlight at
>>> all" behavior of 097128d1bc.
>>
>> To fix the useless highlights for both evenly and unevenly sized hunks
>> (like when all but a semicolon on a line changes), one can loosen the
>> criterion for not highlighting from "do not highlight if 0% of the
>> before and after lines are common between them" to, say, "do not
>> highlight if less than 10% of the before and after lines are common
>> between them".  Then most of these useless highlights are gone for both
>> evenly and unevenly sized hunks.
>
> Yeah, this is an idea I had considered but never actually experimented
> with. It does make some things better, but it also makes some a little
> worse. For example, in 8dbf3eb, the hunk:
>
> -               const char *plain = diff_get_color(ecb->color_diff,
> -                                                  DIFF_PLAIN);
> +               const char *context = diff_get_color(ecb->color_diff,
> +                                                    DIFF_CONTEXT);
>
> currently gets the plain/context change in the first line highlighted,
> as well as the DIFF_PLAIN/DIFF_CONTEXT in the second line. With a 10%
> limit, the second line isn't highlighted. That's correct by the
> heuristic, but it's a bit harder to read, because the highlight draws
> your eye to the first change, and it is easy to miss the second.

Good example, this actually exposes a "bug" in the heuristic.  Each line
is around 15 characters long and the common affix ");" is 2 characters
long, which is about 15% of 15.  So the DIFF_PLAIN/DIFF_CONTEXT pair
ought to be highlighted.

The patch was unintentionally comparing the lengths of the common
affixes against the length of the entire line, whitespace and color
codes and all.  In effect this meant that the 10% threshold was much
higher.  We should compare against the length of the non-boring parts of
the whole line when determining the percentage in common.  Attached is a
revised patch.

>
> Still, I think this is probably a minority case, and it may be
> outweighed by the improvements. The "real" solution is to consider the
> hunk as a whole and do an LCS diff on it, which would show that yes,
> it's worth highlighting both of those spots, as they are a small
> percentage of the total hunk.
>
>> Here is a patch that changes the criterion as mentioned.  Testing this
>> change on the documentation patch 5c31acfb, only two pairs of lines are
>> highlighted instead of six.  On my original patch, the useless highlight
>> is gone.  The useless semicolon-related highlights on e.g. commit
>> 99a2cfb are gone.
>
> Nice, the ones like 99a2cfb are definitely wrong (I had though to fix
> them eventually by treating some punctuation as uninteresting, but I
> suspect the percentage heuristic covers that reasonably well in
> practice).
>
>> Of course, these patches are both hacks but they seem to be surprisingly
>> effective hacks especially when paired together.
>
> The whole script is a (surprisingly effective) hack. ;)
>
>>> So I dunno. IMHO this does more harm than good, and I would not want to
>>> use it myself. But it is somewhat a matter of taste; I am not opposed to
>>> making it a configurable option.
>>
>> That is something I can do :)
>
> Coupled with the 10%-threshold patch, I think it would be OK to include
> it unconditionally. So far we've just been diffing the two outputs and
> micro-analyzing them. The real test to me will be using it in practice
> and seeing if it's helpful or annoying.

-- >8 --

Subject: [PATCH] diff-highlight: don't highlight lines that have little in
  common

---
  contrib/diff-highlight/diff-highlight | 21 +++++++++++++++++----
  1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index 85d2eb0..0cc2b60 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -218,8 +218,21 @@ sub is_pair_interesting {
  	my $suffix_a = join('', @$a[($sa+1)..$#$a]);
  	my $suffix_b = join('', @$b[($sb+1)..$#$b]);

-	return $prefix_a !~ /^$COLOR*-$BORING*$/ ||
-	       $prefix_b !~ /^$COLOR*\+$BORING*$/ ||
-	       $suffix_a !~ /^$BORING*$/ ||
-	       $suffix_b !~ /^$BORING*$/;
+	$prefix_a =~ s/^$COLOR*-$BORING*//;
+	$prefix_b =~ s/^$COLOR*\+$BORING*//;
+	$suffix_a =~ s/$BORING*$//;
+	$suffix_b =~ s/$BORING*$//;
+
+	my $whole_a = join ('', @$a);
+	$whole_a =~ s/^$COLOR*-$BORING*//;
+	$whole_a =~ s/$BORING*$//;
+
+	my $whole_b = join ('', @$b);
+	$whole_b =~ s/^$COLOR*\+$BORING*//;
+	$whole_b =~ s/$BORING*$//;
+
+	# Only bother highlighting if at least 10% of each line is common among
+	# the lines.
+	return ((length($prefix_a)+length($suffix_a))*100 >= length($whole_a)*10) &&
+	       ((length($prefix_b)+length($suffix_b))*100 >= length($whole_b)*10);
  }
-- 
2.4.4.410.g43ed522.dirty
