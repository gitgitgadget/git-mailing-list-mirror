From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-svn: add some in-code documentation (options-related).
Date: Sun, 21 Jun 2009 16:48:30 -0700
Message-ID: <7vmy81p2r5.fsf@alter.siamese.dyndns.org>
References: <1245624521-30769-1-git-send-email-ydirson@altern.org>
	<1245624521-30769-2-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 01:48:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIWm7-0003TE-KD
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 01:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbZFUXs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 19:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753905AbZFUXs2
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 19:48:28 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:61157 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbZFUXs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 19:48:28 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090621234832.TFVV25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 21 Jun 2009 19:48:32 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6noW1c00B4aMwMQ03noWJ2; Sun, 21 Jun 2009 19:48:30 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=O0rbRlyAwSQA:10 a=hpJ7GBawAAAA:8
 a=LkQOcjIEJPOMLNyPyQcA:9 a=eCskbeT-GuQ8LLhL1jgA:7
 a=I35x1WFIxKjtsdpGaYLLYL29V5MA:4 a=JjKPPc8r7fgA:10
X-CM-Score: 0.00
In-Reply-To: <1245624521-30769-2-git-send-email-ydirson@altern.org> (Yann Dirson's message of "Mon\, 22 Jun 2009 00\:48\:40 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122002>

Yann Dirson <ydirson@altern.org> writes:

> +# Option structures here are used to define both command-line options
> +# and git-config keys.  They are handled by read-repo-config().
> +# Options in mixed case and with only a long form are only for the
> +# config file.  All options available from command-line are available
> +# as config-file options too, but without any dash in their names.

Hmm... I am a bit confused.  So for example:

		'authors-file|A=s' => \$_authors,
		'authors-prog=s' => \$_authors_prog,
		'repack:i' => \$Git::SVN::_repack,
		'noMetadata' => \$Git::SVN::_no_metadata,
		'useSvmProps' => \$Git::SVN::_use_svm_props,

authors-file, authors-prog and repack are not MixdCase (and the first and
third are not even "only a long form"), so it is not "only for the config
file".  But noMetadata and useSvmProps are "only for the config file".

It took me a bit to realize that these two equivalence hold:

  "not only for the config file" === "also available as command line option"
  "only for the config file"     === "cannot be given on the command line"

Since "option structures here are used for both command and config", and
"anything usable from command line can be used in config file", logically
it follows that "everything in these option structures here are usable in
the config".  It took me a bit longer than necessary for that to click,
too.

Perhaps I am slow.  But I suspect I am not the slowest around here.

After scratching my head for a few minutes, here is a rephrased
description I came up with (I am not writing this as an improved
suggestion, but to ask you to sanity check if I read what you wanted to
say correctly):

    These are all configurable in the config file (remove dash in their
    names to use these names as the config key).

    Options that have MixedCase names without short format (e.g. noMetadata)
    can only be used from the configuration (iow they cannot be given from
    the command line as options).

But then this raises a couple of questions.

 * What are the examples of MixedCase names that do have short format?
   Are they usable from the command line?

 * %fc_opts() has "noMetadata" and %init_opts() has "no-metadata"; how are
   they related, and how do they affect the above "what's available where
   and how to spell their names" rule you outlined?
