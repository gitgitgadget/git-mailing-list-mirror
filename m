From: Drew Northup <drew.northup@maine.edu>
Subject: Unicode text files (UTF-16 in particular, but also UTF-32)
Date: Tue, 21 Sep 2010 15:26:28 -0400
Message-ID: <1285097188.3802.57.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 21 21:51:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy8rb-0004BW-4Q
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 21:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755619Ab0IUTup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 15:50:45 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:38308 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755333Ab0IUTuo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 15:50:44 -0400
X-Greylist: delayed 1312 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Sep 2010 15:50:44 EDT
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id o8LJQYVX014353
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 21 Sep 2010 15:26:39 -0400
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=1
	Fuz1=1 Fuz2=1
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o8LJQYVX014353
X-MailScanner: Found to be clean
X-MailScanner-SpamScore: sss
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1285702102.01494@Nm6ZHk153VQc/S2YF/ZQNQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156746>

(With reference to 
Message-ID: 00E0B9AC-2A2E-4F95-9B35-F3F63EBC3CF3 () gmail ! com )
"Yeah, the problem is finding someone who needs the feature _and_ is
able/willing to implement it."

Well, 
I'd like to take a stab at it. I've been thinking about how to go about
it for a little over two weeks, and I'm pretty sure I've changed my mind
more times than there are days in the equivalent time period.

Current idea foci:

* UTF-8 BOM can go to hell: I'm not going to extra effort to figure out
what do to with UTF-8 as it seems to be working already for the most
part. I am not planning on forcing anything to unnaturally generate a
BOM when converting to UTF-8. (It sure doesn't look like iconv() does!
At least not by default...) I would like to make sure that all UTF-8 I
deal with is valid--and it looks like that might have been done already.

* UTF-16/UTF-32 detection: Detect VALID UTF-16/UTF-32 containing files.
Files that fail this test are treated as "not detected"--so they are
whatever we currently detect them as being (binary, more likely than
not) or say they are otherwise. My current inclination is to implement
this in a separate source file & header to be included by code such as
convert.c for use. Then the changes needed to convert.c will be smaller
and all of it will be more sensibly contained.

* The commit message is already UTF-8 and this shouldn't change, so I'm
not going to mess with it. However, the utilities that display these and
the diff lines as well shouldn't need to be completely re-worked if we
don't need to. Therefore, I propose using UTF-8 for this (diff, etc.)
even if the in-content encoding is different. This does raise the
invalid UTF-8 not converting to UTF-16/UTF-32 without loss, but if we're
generating invalid UTF-8 we have other problems to begin with.

* Storage of UTF-16/UTF-32 content: Do we want to treat this as all
other texts (raw content), normalizing to LF line ends and such
(requires changes to how we handle LF/CRLF conversions)? Should we store
it as UTF-8 and convert back to the source encoding on export from the
object database (metadata would be required to do this correctly)?

It seems to me as if there are a few things to hash out before getting
beyond the point of accurate unicode [file] content text detection.

Comments, suggestions, and flames (so long as BBQ sauce is provided I
suppose) welcome.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
