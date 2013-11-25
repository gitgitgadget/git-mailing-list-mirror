From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] commit-slab: document clear_$slabname()
Date: Mon, 25 Nov 2013 12:24:09 -0800
Message-ID: <20131125202409.GO4212@google.com>
References: <cover.1385405977.git.tr@thomasrast.ch>
 <7f773c5c5ea16b19840f67ba99961be132940d32.1385405977.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Nov 25 21:24:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl2hh-00031l-Cr
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 21:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756653Ab3KYUYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 15:24:18 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:49170 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716Ab3KYUYR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 15:24:17 -0500
Received: by mail-yh0-f50.google.com with SMTP id b6so3278194yha.37
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 12:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KFBcptx1Ve2d5AboI6qT1TBnww48upMP4LUOXGHu0VI=;
        b=snexn3y8oEVqb0jp6WmAMGy0rbMIKBi8C9/KZGJT4KXLQJxL1XGhUAq6dkOhk/+/U1
         0Er1MsaZ12cr6uVUstZaZA4x9nsu5RaZuePLEqh3KaR6qUWzGcnoxEuVv8kgkhFRFey6
         wv6FczrWbgg4qPMedlsQX6mIlm9WL9pE/7NT54Al0nS5jJA/UI9m725rsg9fffwJijUN
         VnXbJTf6dP2+HNWFb97dWXK8G1XQ2PYlRP6yf4p8nYPORiUmXo9Ai7mI1GNWHtqCwyug
         0WIn1oelC3zqex31zqTTNZMXqi+ii+ubIg/gXpg7WrdwqhSXAcCnth9kuNELeQSDsICb
         NRJg==
X-Received: by 10.236.111.38 with SMTP id v26mr29212361yhg.40.1385411055544;
        Mon, 25 Nov 2013 12:24:15 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id q9sm77812231yhk.16.2013.11.25.12.24.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Nov 2013 12:24:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7f773c5c5ea16b19840f67ba99961be132940d32.1385405977.git.tr@thomasrast.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238342>

Thomas Rast wrote:

> The clear_$slabname() function was only documented by source code so
> far.  Write something about it.

Good idea.

[...]
> --- a/commit-slab.h
> +++ b/commit-slab.h
> @@ -24,6 +24,10 @@
>   *   to each commit. 'stride' specifies how big each array is.  The slab
>   *   that id initialied by the variant without "_with_stride" associates
>   *   each commit with an array of one integer.
> + *
> + * - void clear_indegree(struct indegree *);
> + *
> + *   Free the slab's data structures.

Tense shift (previous descriptions were in the present tense, while
this one is in the imperative).

More importantly, this doesn't answer the questions I'd have if I were
in a hurry, which are what exactly is being freed (has the slab taken
ownership of any memory from the user, e.g. when elemtype is a
pointer?) and whether the slab needs to be init_ ed again.

Maybe something like the following would work?

	- void clear_indegree(struct indegree *);

	  Empties the slab.  The slab can be reused with the same
	  stride without calling init_indegree again or can be
	  reconfigured to a different stride by calling
	  init_indegree_with_stride.

	  Call this function before the slab falls out of scope to
	  avoid leaking memory.

Thanks,
Jonathan
