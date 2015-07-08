From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git: add optional support for full pattern in fetch refspecs
Date: Tue, 07 Jul 2015 21:24:00 -0700
Message-ID: <xmqq615v1dlr.fsf@gitster.dls.corp.google.com>
References: <1436309869-19609-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.iabervon.org>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 06:24:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCgu6-0006b1-4B
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 06:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbbGHEYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 00:24:05 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:33638 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932239AbbGHEYD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 00:24:03 -0400
Received: by iggp10 with SMTP id p10so13224263igg.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 21:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=CzF6RhCeVneJe/150bLJmd+RHsVL2yPCm7y9wNuvr7w=;
        b=MNdPPiaDd6Q8MOyMDxvnUK2ScaLK5LczaILwnu1n7Q3Kyujt56nF128mxt5lDkOmhs
         KvyUBgvwc6j9HMI+qst9hmG4YGrRshsJpYnG11zg/YExZmR6QBvrUCAt7fFPid0cOvX5
         u4vnUhwvTkO9vlDjhpkKJAMYFsGM/yA5l06/162IIPhIRTs4aKk1nHbQG6OKpMQEAgwf
         W8nvItM7CVnnZORh3OgYvhc/ile57rrk0QHL5R0wg+y5PR3FK4+abDkluW2T9iC/9utn
         yjzq7DEjxpLOjUWhnAfknnPgLlSGs84B6dsFJEKrCY78OZS11eTPH6SNmhRdnXle0wkn
         7e8g==
X-Received: by 10.50.43.137 with SMTP id w9mr67381438igl.30.1436329441674;
        Tue, 07 Jul 2015 21:24:01 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by smtp.gmail.com with ESMTPSA id r4sm13378899igh.9.2015.07.07.21.24.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jul 2015 21:24:01 -0700 (PDT)
In-Reply-To: <1436309869-19609-1-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Tue, 7 Jul 2015 15:57:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273635>

Jacob Keller <jacob.e.keller@intel.com> writes:

> +remote.<name>.arbitrarypattern::
> +	When set to true, fetching from this remote will allow arbitrary complex
> +	patterns for the fetch refspecs. For example,
> +	refs/tags/prefix-*:refs/tags/prefix-* will work as expected. Care should be
> +	taken as you could fetch refs into names that don't exist on the remote and
> +	may end up pushing them again later by accident.

Bad name and explanation, unless you truly mean "arbitrary", like
taking something like "refs/ta*/prefix-*-*-foo:refs/*".

More importantly, this is not "pattern"; you are talking about
refspec, I think.

But that probably does not matter.  I do not think this even needs
to exist as an option.

People's existing settings would not have anything other than an
asterisk as a whole path component on each side (or no asterisk
anywhere), and if they had an asterisk anywhere else they would have
gotten an error and wouldn't have made any progress until they fixed
it.  So if you loosen the current rule sligntly and tell them "If
your refspec has an asterisk in it, then you must have one asterisk
on each side of it. That rule hasn't changed. But your asterisks no
longer have to be a whole path component", such a change would not
hurt them.  Their existing setting that work would not notice, and
existing users would not be relying on a refspec with an asterisk as
part of a path component to error out.
