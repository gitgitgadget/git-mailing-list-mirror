From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: fixes to gitweb feature check code
Date: Sun, 16 Nov 2008 13:11:25 -0800
Message-ID: <7vwsf31ima.fsf@gitster.siamese.dyndns.org>
References: <1226759165-6894-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 22:13:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1ovb-0007w2-BX
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 22:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbYKPVLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 16:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbYKPVLv
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 16:11:51 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbYKPVLu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 16:11:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 120F97E5B6;
	Sun, 16 Nov 2008 16:11:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0F0C47E5AF; Sun,
 16 Nov 2008 16:11:33 -0500 (EST)
In-Reply-To: <1226759165-6894-1-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Sat, 15 Nov 2008 15:26:05 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2EA819E0-B423-11DD-81A8-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101161>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> The gitweb_check_feature routine was being used for two different
> purposes: retrieving the actual feature value (such as the list of
> snapshot formats or the list of additional actions), and to check if a
> feature was enabled.

> +# check if a given feature is enabled or not, returning the first (and only)
> +# value of the feature. Comfort code, allowing the use of
> +#   my $bool_feat = gitweb_check_feature('bool_feat');
> +# or
> +#   gitweb_check_feature('bool_feat') or somecode;
> +# instead of
> +#   my ($bool_feat) = gitweb_git_feature('bool_feat');
> +# or
> +#   (gitweb_check_feature('bool_feat'))[0] or somecode;
> +# respectively

What's "Comfort code"?

I'd agree that introduction of gitweb_get_feature() may help avoiding
mistakes at the call sites for Perl illiterates like myself.

> @@ -767,7 +785,7 @@ our $git_dir;
>  $git_dir = "$projectroot/$project" if $project;
>  
>  # list of supported snapshot formats
> -our @snapshot_fmts = gitweb_check_feature('snapshot');
> +our @snapshot_fmts = gitweb_get_feature('snapshot');
>  @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);

And this may be a good change from that point of view, but...

> @@ -810,7 +828,7 @@ sub href (%) {
>  		}
>  	}
>  
> -	my ($use_pathinfo) = gitweb_check_feature('pathinfo');
> +	my $use_pathinfo = gitweb_check_feature('pathinfo');

... I do not think changes like these are warranted.  They have been using
the function _correctly_ by calling it in the list context and I think
they will continue to work with your patch.
