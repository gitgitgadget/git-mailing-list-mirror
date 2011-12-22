From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] attr: map builtin userdiff drivers to well-known extensions
Date: Thu, 22 Dec 2011 00:05:39 -0000
Organization: OPDS
Message-ID: <22866D05066E43DEA0A0EBDF9B7686ED@PhilipOakley>
References: <20111216110000.GA15676@sigill.intra.peff.net> <A8E08CC616E248EC8F9000DD86F228E0@PhilipOakley> <20111216193253.GD19924@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>,
	"Brandon Casey" <drafnel@gmail.com>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 22 01:05:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdW9v-0004Z4-8H
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 01:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607Ab1LVAFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 19:05:14 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:58568 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751981Ab1LVAFM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Dec 2011 19:05:12 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AogAAOhy8k5cGnbG/2dsb2JhbABDhQ+FTZBykFaBBoFtAQQBAQUIAQEZFR4BASELAgMFAgEDDgcBAgICBSECAhQBBBoGBxcGEwgCAQIDAQOFNIIpCwalf5FTgS+JSjNjBI0FKpoD
X-IronPort-AV: E=Sophos;i="4.71,390,1320624000"; 
   d="scan'208";a="375435546"
Received: from host-92-26-118-198.as13285.net (HELO PhilipOakley) ([92.26.118.198])
  by out1.ip01ir2.opaltelecom.net with SMTP; 22 Dec 2011 00:05:10 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187594>

From: "Jeff King" <peff@peff.net> Sent: Friday, December 16, 2011 7:32 PM
> On Fri, Dec 16, 2011 at 07:26:00PM -0000, Philip Oakley wrote:
>
>> >+ "*.m diff=objc",
>>
>> There is a conflict here with the Matlab community which also uses
>> "*.m" files for its scripts and code.
>> They fit the "It's not that hard to do, but it's an extra step that
>> the user might not even know is an option." rationale.
>>
>> If the objc.m is used as a default it must be overidable easily, and
>> listed in the appropriate documentation to mitigate the "might not
>> even know" risk.
>
> It is easily overridable; just put your own "*.m" (or anything that
> matches your files) entry into your gitattributes file. I'm more
> concerned that people will start getting worse results than with the
> default, and not know how to fix it.
>
> If you have some Matlab files, would you mind doing diffs with the
> default driver and with the objc driver, and comment on how good or bad
> the results are?
>
> -Peff
> --
Sorry for the delay.
I started with a fresh install of Msysgit 1.7.8 for my tests, and created a 
test repo from a set of old project zip files, retaining only the *.m files. 
i.e. it is a real hack project. The diff shown was a small tweak & 
investigation step. Below are the three cases of:
1. plain vanilla install (no .gitattributes file)
2. with *.m=matlab in .gitattributes
3. with *.m=objc in .gitattributes

The "*.m=matlab" does give better (proper) hunk headers as it picks out the 
"^%%" comment line which starts a code block . For option 3 (ObjC) they are 
empty (which is poor). The plain vanila (default) hunk headers are so-so.

There is a vast quantity (10,000+) of Matlab examples on the Mathworks 
(vendor) File exchange web site, if anyone is interested, 
http://www.mathworks.com/matlabcentral/fileexchange/?sort=date_desc_updated&term=

Roughly my command sequence was:
$git diff HEAD HEAD~1  -p > test.txt
#rename test.txt to suitable name

$echo "*.m diff=matlab" >>.gitattributes
#repeat

$echo "*.m diff=objc" >>.gitattributes
#repeat

-----------------
1. plain vanilla install (no .gitattributes file)

diff --git a/detect_and_track.m b/detect_and_track.m
index 0f0356d..69d650f 100644
--- a/detect_and_track.m
+++ b/detect_and_track.m
@@ -161,9 +161,8 @@ sz = [960, 1280]; pixshrink = 10; % 10 is a guess!
 parabolic = pararate(sz(2), pixshrink);

 %% Set up the filters.
-% changed sizes to be an extra pixel all round both inner & outer
-hsize = [15 17]; % [11 13] size of (square) filter [vert horiz]
-inhsize = [7 7] ; % [5 5] size of inner filter
+hsize = [11 13]; % size of (square) filter [vert horiz]
+inhsize = [5 5] ; % size of inner filter
 % siz=[hsize hsize];
 sigma2 = [3.5 4.5]; % outer radius
 sigma3 = [1.4 1.4]; % inner radius
@@ -290,7 +289,7 @@ for TframeNum = FrameRange;  %change this value to read 
in a different frame
             % shrink the image
             Image = Shrink2(Image);
         end
-        if any(find(J==[1 2 3 4])) %  5 6 7
+        if any(find(J==[1 2])) %  3 4 5 6 7
             % list the levels you want procesed / rectangles shown
             % i.e. [1 2 3 4 5 6 7]
             [localmean localstdev ] = Point_Filter_cross3(Image,Table);
diff --git a/do_noise_ratios.m b/do_noise_ratios.m
index 663d898..dd73ed0 100644
--- a/do_noise_ratios.m
+++ b/do_noise_ratios.m
@@ -10,7 +10,7 @@

 % NewFrame{J,2}=localstdev; %

-for baselev=1:3;
+for baselev=1:2;
 Noise_Ratio = Stretch2(NewFrame{baselev+1,2}) ./  NewFrame{baselev,2} ;
 Noise_Ratio(Noise_Ratio>5)=5;
 figure(49+baselev); colorbar;


-----------------
2. with *.m=matlab in .gitattributes

diff --git a/detect_and_track.m b/detect_and_track.m
index 0f0356d..69d650f 100644
--- a/detect_and_track.m
+++ b/detect_and_track.m
@@ -161,9 +161,8 @@ %% set up the camera Configurations
 parabolic = pararate(sz(2), pixshrink);

 %% Set up the filters.
-% changed sizes to be an extra pixel all round both inner & outer
-hsize = [15 17]; % [11 13] size of (square) filter [vert horiz]
-inhsize = [7 7] ; % [5 5] size of inner filter
+hsize = [11 13]; % size of (square) filter [vert horiz]
+inhsize = [5 5] ; % size of inner filter
 % siz=[hsize hsize];
 sigma2 = [3.5 4.5]; % outer radius
 sigma3 = [1.4 1.4]; % inner radius
@@ -290,7 +289,7 @@ %% Loop Starts here
             % shrink the image
             Image = Shrink2(Image);
         end
-        if any(find(J==[1 2 3 4])) %  5 6 7
+        if any(find(J==[1 2])) %  3 4 5 6 7
             % list the levels you want procesed / rectangles shown
             % i.e. [1 2 3 4 5 6 7]
             [localmean localstdev ] = Point_Filter_cross3(Image,Table);
diff --git a/do_noise_ratios.m b/do_noise_ratios.m
index 663d898..dd73ed0 100644
--- a/do_noise_ratios.m
+++ b/do_noise_ratios.m
@@ -10,7 +10,7 @@ %% do_noise_ratios

 % NewFrame{J,2}=localstdev; %

-for baselev=1:3;
+for baselev=1:2;
 Noise_Ratio = Stretch2(NewFrame{baselev+1,2}) ./  NewFrame{baselev,2} ;
 Noise_Ratio(Noise_Ratio>5)=5;
 figure(49+baselev); colorbar;


-----------------
3. with *.m=objc in .gitattributes

diff --git a/detect_and_track.m b/detect_and_track.m
index 0f0356d..69d650f 100644
--- a/detect_and_track.m
+++ b/detect_and_track.m
@@ -161,9 +161,8 @@
 parabolic = pararate(sz(2), pixshrink);

 %% Set up the filters.
-% changed sizes to be an extra pixel all round both inner & outer
-hsize = [15 17]; % [11 13] size of (square) filter [vert horiz]
-inhsize = [7 7] ; % [5 5] size of inner filter
+hsize = [11 13]; % size of (square) filter [vert horiz]
+inhsize = [5 5] ; % size of inner filter
 % siz=[hsize hsize];
 sigma2 = [3.5 4.5]; % outer radius
 sigma3 = [1.4 1.4]; % inner radius
@@ -290,7 +289,7 @@
             % shrink the image
             Image = Shrink2(Image);
         end
-        if any(find(J==[1 2 3 4])) %  5 6 7
+        if any(find(J==[1 2])) %  3 4 5 6 7
             % list the levels you want procesed / rectangles shown
             % i.e. [1 2 3 4 5 6 7]
             [localmean localstdev ] = Point_Filter_cross3(Image,Table);
diff --git a/do_noise_ratios.m b/do_noise_ratios.m
index 663d898..dd73ed0 100644
--- a/do_noise_ratios.m
+++ b/do_noise_ratios.m
@@ -10,7 +10,7 @@

 % NewFrame{J,2}=localstdev; %

-for baselev=1:3;
+for baselev=1:2;
 Noise_Ratio = Stretch2(NewFrame{baselev+1,2}) ./  NewFrame{baselev,2} ;
 Noise_Ratio(Noise_Ratio>5)=5;
 figure(49+baselev); colorbar;
