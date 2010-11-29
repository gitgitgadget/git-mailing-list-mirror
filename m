From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 1/2] [RFC] Use --find- instead of --detect- as prefix for long forms of -M and -C.
Date: Mon, 29 Nov 2010 14:52:59 -0800
Message-ID: <34E173EF-658B-49CC-99C4-C455074D4A05@sb.org>
References: <1289420833-20602-1-git-send-email-ydirson@altern.org> <1289420833-20602-2-git-send-email-ydirson@altern.org> <7884E3F5-D622-49E2-BEBE-12936F388C30@sb.org> <7vmxorzr8k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 23:53:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNCb7-0008Bu-Kk
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 23:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257Ab0K2WxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 17:53:05 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62284 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242Ab0K2WxC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Nov 2010 17:53:02 -0500
Received: by pva4 with SMTP id 4so783193pva.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 14:53:02 -0800 (PST)
Received: by 10.142.163.2 with SMTP id l2mr6263125wfe.376.1291071181941;
        Mon, 29 Nov 2010 14:53:01 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id w42sm8083263wfh.15.2010.11.29.14.53.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 14:53:00 -0800 (PST)
In-Reply-To: <7vmxorzr8k.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162438>

On Nov 29, 2010, at 2:42 PM, Junio C Hamano wrote:

>> I'm not sure I like the wording --find-copies and --find-renames. Maybe I'm
>> just being silly, but it sounds like those are directives, saying "I want you
>> to find copies/renames", as opposed to just saying "while you're working you
>> should also detect copies/renames". The original flag --find-copies-harder
>> is a bit different, because it's modifying the action of finding copies
>> rather than making finding copies the prime directive.
>> 
>> On the other hand, --detect-copies and --detect-renames sounds to me like
>> you're just telling it that it should, well, detect copies/renames as it goes
>> about its business.
> 
> Hmm, but your "harder is different" comes from the knowledge of how it
> works (namely, the set of paths the frontend feeds to diffcore is made
> larger), which does not concern the end user.  Also the same logic of
> yours can be applied to argue for renaming "detect renames" to "find
> renames", as it _does_ tell diffcore to activate the rename finding
> machinery, i.e. it is modifying the action of computing the differences.

I will admit I am not an unbiased observer, but I still think
--find-copies-harder is less of a directive and more of a modifier than
--find-copies is.

> So I think using the same verb would make sense, either by introducing a
> new synonym "detect-copies-harder", or by giving longer "find-copies" and
> "find-renames" options to not-so-hard ones.

Given my druthers, I'd prefer to go with --detect-copies-harder, but at this
point I don't have as much of a strong preference anymore.

-Kevin Ballard

-- 8< --
Subject: [PATCH] diff: add --detect-copies-harder as a synonym for --find-copies-harder


Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 Documentation/diff-options.txt |    1 +
 diff.c                         |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index f3e9538..7246e10 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -251,6 +251,7 @@ endif::git-log[]
 	If `n` is specified, it has the same meaning as for `-M<n>`.
 
 --find-copies-harder::
+--detect-copies-harder::
 	For performance reasons, by default, `-C` option finds copies only
 	if the original file of the copy was modified in the same
 	changeset.  This flag makes the command
diff --git a/diff.c b/diff.c
index 6991ed4..faa8dc0 100644
--- a/diff.c
+++ b/diff.c
@@ -3198,7 +3198,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_SET(options, TEXT);
 	else if (!strcmp(arg, "-R"))
 		DIFF_OPT_SET(options, REVERSE_DIFF);
-	else if (!strcmp(arg, "--find-copies-harder"))
+	else if (!strcmp(arg, "--find-copies-harder") || !strcmp(arg, "--detect-copies-harder"))
 		DIFF_OPT_SET(options, FIND_COPIES_HARDER);
 	else if (!strcmp(arg, "--follow"))
 		DIFF_OPT_SET(options, FOLLOW_RENAMES);
-- 
1.7.3.2.615.g83f72.dirty
