From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] blame.c: don't drop origin blobs as eagerly
Date: Fri, 27 May 2016 17:00:25 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605271633230.4449@virtualbox>
References: <1464356141-3797-1-git-send-email-dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri May 27 17:00:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6JFf-0004Os-Pl
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 17:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbcE0PAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 11:00:36 -0400
Received: from mout.gmx.net ([212.227.15.15]:60678 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbcE0PAf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 11:00:35 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MXZbS-1b3TrS1B5S-00WYRC; Fri, 27 May 2016 17:00:24
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1464356141-3797-1-git-send-email-dak@gnu.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:/OZt9xXqohQSYMzI3ZkPRKml/7PTM1MYunbFqvrsv/TTx5nKFRI
 YCfAut2zaAifzkoBf2bio/CXHV6IpLH8dJ/eDjQlKx5o6d0F3SXBaoHTxPI0vrXdN5AV4jX
 5IwVi0Mk7NeBKm8o6gmOLkGM6KYhk8rRNQC3e9HQHWC1ukNo1iPMipPNThSQxsBjLajFyfr
 igRAQ4v0UAU6ZyhBABk+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H77ZccM/DgU=:XakhuNFIs/geKOxBqwacCx
 +6xNlSui6pg9usmx+rtBMgjjcQCINvy38iW4n6NPVNKkoKhnCOHOX78uFYoCFdZPH5z5IXw1W
 wJi/A/exqbi85O4JkjlBp0C91M6VDJoO+IsKRNM4JfJNVXiFUoYk8sZ9eJzYhcF1oJnWTIcp+
 lSghtPQy+AvKnxiaUut+fZlhhAUwIuOZh35qm6LPaq+eIUX1xV17RPZHth40dUmmsv9fQm6Ol
 5DjOL6wraHGZa9smhpj/Lmrb/YCiCvmfAmufGfqBoeEDV5/xSm7dMOOaMY1pPno5D8VG/PMtH
 XT7+dMbX5CVk3+7gF9Poa3wGlg2/0YziIEFQvLepHhOzPFFvsUjRmDqFUwCyOxSz0sQsxi3Q+
 qMHLQ+WZkhK3t1YoSB2PJGLKjfQDDAKj6hgaDJtYtIdKyIvkSD7gPjxWbXf1CqnYL7dBci1Tb
 QseiH+RJzGdNl5xsE9p7HQ5fG3bxUnfPyHIximaMihRPtiE8JipRsqF8mNGCeOmpLfksjz9tx
 74YtSqJFR+AYlzf2q3Ty2BGlwTNXxFliQf5ilMMrlRAUB+2xa4SHRZ15c7UQsemHSnm8eBsc8
 YhRb6Ihh6Vm39aUWI6UCh/CJYSW8BNOnjakuABWytHQ6Ntm6GjifVLq4r/EQ5MkbCDTAjH77F
 d6nRZ/XTzrIO9F0RerrQFPIzOtKYv4vQXsC78QvsS7GSMF5NAdPFUosyCHaQE3clEmuX9Akyx
 nUXxv5rcKCcwyyO6/cjUx6B8PI79ifwtTrPanl9kb7zIxYCvjGnPo24RP84ZQnqZ1eGFpqRF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295760>

Hi David,

it is good practice to Cc: the original author of the code in question, in
this case Junio. I guess he sees this anyway, but that is really just an
assumption.

On Fri, 27 May 2016, David Kastrup wrote:

> When a parent blob already has chunks queued up for blaming, dropping
> the blob at the end of one blame step will cause it to get reloaded
> right away, doubling the amount of I/O and unpacking when processing a
> linear history.

It is obvious from your commit message that you have studied the code
quite deeply. To make it easier for the reader (which might be your future
self), it is advisable to give at least a little bit of introduction, e.g.
what the "parent blob" is.

I would *guess* that it is the blob corresponding to the same path in the
parent of the current revision, but that should be spelled out explicitly.

> Keeping such parent blobs in memory seems like a reasonable
> optimization.  It's conceivable that this may incur additional memory

This sentence would be easier to read if "It's conceivable that" was
simply deleted.

> pressure particularly when the history contains lots of merges from
> long-diverged branches.  In practice, this optimization appears to
> behave quite benignly,

Why not just stop here? I say that because...

> and a viable strategy for limiting the total amount of cached blobs in a
> useful manner seems rather hard to implement.

... this sounds awfully handwaving. Since we already have reference
counting, it sounds fishy to claim that simply piggybacking a global
counter on top of it would be "rather hard".

> In addition, calling git-blame with -C leads to similar memory retention
> patterns.

This is a red herring. Just delete it. I, for one, being a heavy user of
`git blame`, could count the number of times I used blame's -C option
without any remaining hands. Zero times.

Besides, -C is *supposed* to look harder. By that argument, you could read
all blobs in rev-list even when the user did not specify --objects
"because --objects leads to similar memory retention patterns". So: let's
just forget about that statement.

The commit message is missing your sign-off.

Also: is there an easy way to reproduce your claims of better I/O
characteristics? Something like a command-line, ideally with a file in
git.git's own history, that demonstrates the I/O before and after the
patch, would be an excellent addition to the commit message.

Further: I would have at least expected some rudimentary discussion why
this patch -- which seems to at least partially contradict 7c3c796 (blame:
drop blob data after passing blame to the parent, 2007-12-11) -- is not
regressing on the intent of said commit.

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 21f42b0..2596fbc 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1556,7 +1556,8 @@ finish:
>  	}
>  	for (i = 0; i < num_sg; i++) {
>  		if (sg_origin[i]) {
> -			drop_origin_blob(sg_origin[i]);
> +			if (!sg_origin[i]->suspects)
> +				drop_origin_blob(sg_origin[i]);
>  			origin_decref(sg_origin[i]);
>  		}

It would be good to mention in the commit message that this patch does not
change anything for blobs with only one remaining reference (the current
one) because origin_decref() would do the same job as drop_origin_blob
when decrementing the reference counter to 0.

In fact, I suspect that simply removing the drop_origin_blob() call might
result in the exact same I/O pattern.

Ciao,
Johannes
