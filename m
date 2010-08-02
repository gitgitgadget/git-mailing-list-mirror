From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 1/3 v4] Add a macro DIFF_QUEUE_CLEAR.
Date: Mon, 2 Aug 2010 14:47:29 +0200
Message-ID: <20100802124729.GK12084MdfPADPa@purples>
References: <1273207949-18500-1-git-send-email-struggleyb.nku@gmail.com>
 <1273207949-18500-2-git-send-email-struggleyb.nku@gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 15:16:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ofut0-0002qA-Dl
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 15:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651Ab0HBNQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 09:16:51 -0400
Received: from cavspool01.kulnet.kuleuven.be ([134.58.240.41]:60620 "EHLO
	cavspool01.kulnet.kuleuven.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752002Ab0HBNQv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 09:16:51 -0400
X-Greylist: delayed 1758 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Aug 2010 09:16:50 EDT
Received: from cavuit01.kulnet.kuleuven.be (cavuit01.kulnet.kuleuven.be [134.58.240.43])
	by cavspool01.kulnet.kuleuven.be (Postfix) with ESMTP id ACA4FD2393
	for <git@vger.kernel.org>; Mon,  2 Aug 2010 14:48:12 +0200 (CEST)
Received: from smtps01.kuleuven.be (smtpshost01.kulnet.kuleuven.be [134.58.240.74])
	by cavuit01.kulnet.kuleuven.be (Postfix) with ESMTP id 56FB47B804A;
	Mon,  2 Aug 2010 14:47:30 +0200 (CEST)
Received: from purples.kotnet.org (10-92-82-72.kotnet.org [10.92.82.72])
	by smtps01.kuleuven.be (Postfix) with ESMTP id 13E5C31E702;
	Mon,  2 Aug 2010 14:47:30 +0200 (CEST)
Received: by purples.kotnet.org (Postfix, from userid 1000)
	id 05F052C40; Mon,  2 Aug 2010 14:47:29 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
Content-Disposition: inline
In-Reply-To: <1273207949-18500-2-git-send-email-struggleyb.nku@gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-KULeuven-Information: Katholieke Universiteit Leuven
X-KULeuven-Scanned: Found to be clean
X-Spam-Status: not spam, SpamAssassin (not cached, score=-49.9, required 5,
	autolearn=disabled, KUL_SMTPS -50.00, RDNS_DYNAMIC 0.10)
X-KULeuven-Envelope-From: skimo@kotnet.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152408>

On Thu, May 06, 2010 at 09:52:27PM -0700, Bo Yang wrote:
> Refactor the diff_queue_struct code, this macro help
> to reset the structure.
> 
[..]
> 
> diff --git a/diff.c b/diff.c
> index e40c127..4a350e3 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2540,6 +2540,7 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
>  void diff_setup(struct diff_options *options)
>  {
>  	memset(options, 0, sizeof(*options));
> +	memset(&diff_queued_diff, 0, sizeof(diff_queued_diff));
>  

What's this line for?  It doesn't seem to be explained by the commit
message and it breaks "git diff-files -p --submodule".
Without this line, I get the following output in one of my projects:

    Submodule barvinok contains untracked content
    Submodule barvinok contains modified content
    Submodule barvinok e129555..833e4a6:
      > iscc: use simplified CLooG interface
    Submodule cloog contains untracked content
    Submodule cloog f083938..4684a24:
      > partial doc
      > cloog_names_read_strings: do not generate names if they cannot be read
      > cloog_program_read: separate reading from input from construction of CloogProgram
    Submodule cloog-polylib contains untracked content
    Submodule cloog-polylib contains modified content
    Submodule isl contains untracked content
    Submodule isl 892fb27..5292e00:
      > isl_transitive_closure.c: anonymize input map during incremental computation
      > isl_transitive_closure.c: keep track of domains for Floyd-Warshall
      > isl_dim_drop: always remove tuple name, even if number of dims to drop is zero
      > isl_dim_set_tuple_name: allow explicit removal of tuple name
    Submodule isl-polylib contains untracked content
    Submodule isl-polylib 531cb00..e9e2edf:
      > stop using isl_basic_map internals
    Submodule polylib contains untracked content

With the line, I only get

    Submodule barvinok contains untracked content
    Submodule barvinok contains modified content
    Submodule barvinok e129555..833e4a6:
      > iscc: use simplified CLooG interface

skimo
