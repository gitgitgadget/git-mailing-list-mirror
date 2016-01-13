From: Victor Leschuk <vleschuk@accesssoftek.com>
Subject: RE: [PATCH] git-svn: loosen config globs limitations
Date: Tue, 12 Jan 2016 22:40:00 -0800
Message-ID: <6AE1604EE3EC5F4296C096518C6B77EE5FF2055FF9@mail.accesssoftek.com>
References: <1452522358-16943-1-git-send-email-vleschuk@accesssoftek.com>,<20160113031601.GA28224@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>,
	Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:42:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJF8E-0005B1-Lo
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 07:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbcAMGls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 01:41:48 -0500
Received: from mail.accesssoftek.com ([12.202.173.171]:35185 "EHLO
	mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbcAMGlr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jan 2016 01:41:47 -0500
Received: from mail.accesssoftek.com ([172.16.0.71]) by mail.accesssoftek.com
 ([172.16.0.71]) with mapi; Tue, 12 Jan 2016 22:41:43 -0800
Thread-Topic: [PATCH] git-svn: loosen config globs limitations
Thread-Index: AdFNsRus0xX+ToMsREmJHPwt3XMB0AAHB5KM
In-Reply-To: <20160113031601.GA28224@dcvr.yhbt.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283881>

Thanks a lot Eric,

I agree with all corrections, I also noticed the "wildcard directories" message situation when was creating test for the patch, however didn't want mix up unrelated changes for this patchset.

--
Best Regards,
Victor
________________________________________
From: Eric Wong [normalperson@yhbt.net]
Sent: Tuesday, January 12, 2016 19:16
To: Victor Leschuk
Cc: git@vger.kernel.org; Victor Leschuk; gitster@pobox.com
Subject: Re: [PATCH] git-svn: loosen config globs limitations

Thanks, I made a minor cleanup and applied with --whitespace=fix
to remove spaces from indentation.

--- a/perl/Git/SVN/GlobSpec.pm
+++ b/perl/Git/SVN/GlobSpec.pm
@@ -15,8 +15,10 @@ sub new {
                         $part !~ /^\{[^{}]+\}/) {
                        die "Invalid pattern in '$glob': $part\n";
                }
-               my $nstars = $part =~ tr/\*//;
-               die "Only one '*' is allowed in a pattern: '$part'\n" if $nstars > 1;
+               my $nstars = $part =~ tr/*//;
+               if ($nstars > 1) {
+                       die "Only one '*' is allowed in a pattern: '$part'\n";
+               }
                if ($part =~ /(.*)\*(.*)/) {
                        die $die_msg if $state eq "right";
                        my ($l, $r) = ($1, $2);

So I'll push out with the following commit message:

Subject: [PATCH] git-svn: loosen config globs limitations

Expand the area of globs applicability for branches and tags
in git-svn. It is now possible to use globs like 'a*e', or 'release_*'.
This allows users to avoid long lines in config like:

        branches = branches/{release_20,release_21,release_22,...}

In favor of:

        branches = branches/release_*

[ew: amended commit message, minor formatting and style fixes]

Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
Signed-off-by: Eric Wong <normalperson@yhbt.net>



I also noticed the "Only one set of wildcard directories" error
message is unnecessary long and "wildcard directories" should
probably be shortened to "wildcards" to avoid wrapping in a terminal.
That will probably be a separate patch for me.
