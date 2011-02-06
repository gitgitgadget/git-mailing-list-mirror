From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 2/2] git-p4: Add copy detection support
Date: Sat, 5 Feb 2011 19:25:47 -0500
Message-ID: <20110206002547.GB31245@arf.padd.com>
References: <1296429563-18390-1-git-send-email-vitor.hda@gmail.com>
 <1296429563-18390-2-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 01:26:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlsS1-0004xo-Lz
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 01:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754Ab1BFAZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 19:25:57 -0500
Received: from honk.padd.com ([74.3.171.149]:38159 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640Ab1BFAZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 19:25:56 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 4BB212E8;
	Sat,  5 Feb 2011 16:25:55 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 9D36F31ADE; Sat,  5 Feb 2011 19:25:47 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1296429563-18390-2-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166134>

vitor.hda@gmail.com wrote on Sun, 30 Jan 2011 23:19 +0000:
> Add new config options:
>     git-p4.detectCopies         - Enable copy detection.
>     git-p4.detectCopiesHarder   - Find copies harder.
> The detectCopies option should be set to a true/false value.
> The detectCopiesHarder option should be set to true/false value.
> P4Submit can now process diff-tree C status and integrate files accordingly.
> ---
[..]
> +        detectCopies = gitConfig("git-p4.detectCopies")
> +        if len(detectCopies) and detectCopies.lower() != "false" > 0:
> +            diffOpts += " -C"
> +
> +        detectCopiesHarder = gitConfig("git-p4.detectCopiesHarder")
> +        if len(detectCopiesHarder) > 0 and detectCopiesHarder.lower() != "false":
> +            diffOpts += " --find-copies-harder"
> +

I like it, but same weirdness with != > 0.

> +            elif modifier == "C":
> +                src, dest = diff['src'], diff['dst']
> +                p4_system("integrate -Dt \"%s\" \"%s\"" % (src, dest))
> +                if diff['src_sha1'] != diff['dst_sha1']:
> +                    p4_system("edit \"%s\"" % (dest))
> +                if isModeExecChanged(diff['src_mode'], diff['dst_mode']):
> +                    filesToChangeExecBit[dest] = diff['dst_mode']
> +                os.unlink(dest)
> +                editedFiles.add(dest)

You can use integrate -t to force the filetype even if the file
already existed, and skip the whole execbit change.

		-- Pete
