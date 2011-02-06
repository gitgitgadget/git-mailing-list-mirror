From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 2/2] git-p4: Add copy detection support
Date: Sun, 6 Feb 2011 17:05:46 -0500
Message-ID: <20110206220546.GA9024@mew.padd.com>
References: <1296429563-18390-1-git-send-email-vitor.hda@gmail.com>
 <1296429563-18390-2-git-send-email-vitor.hda@gmail.com>
 <20110206002547.GB31245@arf.padd.com>
 <AANLkTi=Awi6d77QcbbZ2rDTv6LpP+qjsReJ5=4NyhUBz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 23:06:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmCjy-0007kp-U8
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 23:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772Ab1BFWFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 17:05:49 -0500
Received: from honk.padd.com ([74.3.171.149]:34152 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753295Ab1BFWFt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 17:05:49 -0500
Received: from mew.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 5B98B2E8;
	Sun,  6 Feb 2011 14:05:48 -0800 (PST)
Received: by mew.padd.com (Postfix, from userid 7770)
	id 7014F205FC; Sun,  6 Feb 2011 17:05:46 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=Awi6d77QcbbZ2rDTv6LpP+qjsReJ5=4NyhUBz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166206>

vitor.hda@gmail.com wrote on Sun, 06 Feb 2011 17:25 +0000:
> Hi Pete,
> 
> On Sun, Feb 6, 2011 at 12:25 AM, Pete Wyckoff <pw@padd.com> wrote:
> > You can use integrate -t to force the filetype even if the file
> > already existed, and skip the whole execbit change.
> 
> (Copying help text:
> 	The -t flag makes the source file's filetype propagate to the target
> 	file.  Normally, the target file retains its previous filetype.
> 	Newly branched files always use the source file's filetype.  The
> 	filetype can still be changed before 'p4 submit' with 'p4 reopen'.
> )
> 
> Since in git we're only considering newly branched files, I think in
> this case "-t" will not add anything. In fact, what is being done here
> is detecting exec bit changes from source to target files - we're not
> trying to force P4 to use the source's exec bit. Do you agree?

That sounds fine to me.  The code seemed to indicate that
sometimes the destination file exists.

> +            elif modifier == "C":
> +                src, dest = diff['src'], diff['dst']
> +                p4_system("integrate -Dt \"%s\" \"%s\"" % (src, dest))
> +                if diff['src_sha1'] != diff['dst_sha1']:
> +                    p4_system("edit \"%s\"" % (dest))
> +                if isModeExecChanged(diff['src_mode'], diff['dst_mode']):
> +                    filesToChangeExecBit[dest] = diff['dst_mode']
> +                os.unlink(dest)
> +                editedFiles.add(dest)

If you're happy the dest never exists, you may be able to get rid
of the edit step and the mode-change check entirely.  As long as
you've tested this, you're the expert here.  The change makes
sense overall.

		-- Pete
