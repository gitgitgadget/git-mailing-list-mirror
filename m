From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] refs: loosen restriction on wildcard "*" refspecs
Date: Wed, 22 Jul 2015 15:04:16 -0700
Message-ID: <xmqqio9brgrj.fsf@gitster.dls.corp.google.com>
References: <1437599133-13012-1-git-send-email-jacob.e.keller@intel.com>
	<1437599133-13012-3-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.iabervon.org>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 00:04:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZI27m-0001mf-81
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 00:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbbGVWEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 18:04:21 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36836 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279AbbGVWES (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 18:04:18 -0400
Received: by pdjr16 with SMTP id r16so147710719pdj.3
        for <git@vger.kernel.org>; Wed, 22 Jul 2015 15:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=3B8eTnKeTRjx+ndNrllKE0bBRhwSGnxc46gySYBAK10=;
        b=PkTChhelWbFniM87exPHYZHbeiUS5aJD4R+q4EfohdQCu5X2mfHfvpMVg4eVHVWqTm
         fKiBeojxnNazdQyl9XRid5axZb2r+H+EjYSJvFxqivwZlCMeosBo42POrTkO+781PrEs
         ghUH3V+CnGiL6iohl9V3Ue6B5FeZIXXsFQ+P74htqd2nb9WaY3TeSBj7P9MWWkZ3mfF+
         zc7ZGGX2LCRpSaKkOob27SlbRRLqsHcg/fyV7k46g3AQXvP5c2V88cVILFoR+GoIdd14
         Wb1ZVEcKqk5S/NQA6y+b4wbdk0pqh/rdQDSf+h43dNRjgT1M5AAjtWrv+ea16l9nJpXL
         0iwg==
X-Received: by 10.67.8.71 with SMTP id di7mr10830741pad.46.1437602658358;
        Wed, 22 Jul 2015 15:04:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2d07:10eb:6a1b:8773])
        by smtp.gmail.com with ESMTPSA id i10sm5049784pdr.78.2015.07.22.15.04.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 Jul 2015 15:04:17 -0700 (PDT)
In-Reply-To: <1437599133-13012-3-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Wed, 22 Jul 2015 14:05:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274472>

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Modify logic of check_refname_component and add a new disposition
> regarding "*". Allow refspecs that contain a single "*" if
> REFNAME_REFSPEC_PATTERN is set. Change the function to pass the flags as
> a pointer, and clear REFNAME_REFSPEC_PATTERN after the first "*" so that
> only a single "*" is accepted.
>
> This loosens restrictions on refspecs by allowing patterns that have
> a "*" within a component instead of only as the whole component. Also
> remove the code that hangled refspec patterns in check_refname_format
> since it is now handled via the check_refname_component logic.
>
> Now refs such as `for/bar*:foo/bar*` and even `foo/bar*:foo/baz*` will
> be accepted. This allows users more control over what is fetched where.
> Since users must modify the default by hand to make use of this
> functionality it is not considered a large risk. Any refspec which
> functioned before shall continue functioning with the new logic.


Thanks.  Now I can read the changes to the code in these two commits
and see that they both make sense ;-)

The above description seem to use "ref" and "refspec" rather
liberally, so I'll rewrite some parts of it to clarify while
queuing.

By the way, have you run test suite before sending this (or any
previous round of this) patch?  This seems to break t5511-refspec.sh
for me.

 
