From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 10/13] remote.c: make match_refs() copy src ref before 
	assigning to peer_ref
Date: Mon, 23 Feb 2009 22:06:42 -0500
Message-ID: <76718490902231906n620aac40x5c0663fd420c7f39@mail.gmail.com>
References: <cover.1235368324.git.jaysoffian@gmail.com>
	 <75e083170cea799499bf66792a1c3950b29d6021.1235368324.git.jaysoffian@gmail.com>
	 <7vocwspqhc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 04:08:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbneV-0006vG-En
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 04:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbZBXDGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 22:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbZBXDGo
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 22:06:44 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:9426 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbZBXDGo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 22:06:44 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2245385rvb.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 19:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6U/aaX2vH/1TmrJ4i/mqGEV95aL5Du0CECCFGQD4HE8=;
        b=rcdR8BseKBZevy2L2b0RgP9vOk+WT73sARUtH8qbYBpyJeIyy0nrZGVfWMTO8/PeqF
         3xjzquhaEEZ8Z3GLrLRk7VSAXQ8hAafgF19hsmRbmB+ihl1/b5zxeYO7ojZ7dGOGGV7s
         H7k3/YQc8mLu3vRhFpzfmpQfi2DD9Syh/KtvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dclYHpWvOrkXfUdRLp+/o2SCgmeCWkyY+LqIPk4L3pTRBw4NIDSPRYudEpBkk0x/6r
         BL48AvdOyyeq7/rlK/v10JQia/pCI5fd4aKduTTg3RdLYQFjY253uvrFu25PGrV3zFlc
         Iu+ZaQytA5cWz3J/AZUxQiDrBAfiCSjt0gOVw=
Received: by 10.141.155.15 with SMTP id h15mr2317518rvo.158.1235444802309; 
	Mon, 23 Feb 2009 19:06:42 -0800 (PST)
In-Reply-To: <7vocwspqhc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111199>

On Mon, Feb 23, 2009 at 8:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> If this issue was present before you started touching the affected code,
> it should come much earlier in the series than [10/13].  If on the other
> hand this was introduced by earlier one in the series, the patch that
> introduced the bug should be corrected in place in the sequence without
> this patch.

This issue existed before, but the other callers of match_heads() only
call it once before the process terminates, and don't bother to free
what it returns. So those callers didn't notice. This topic introduces
the first caller that calls match_heads() repeatedly, so it frees the
returned ref list after it has copied out what it needs.

The change is independent and can be moved anywhere in the series, or
even introduced as a patch independent of the series itself. Which
would you prefer? (Actually, would you mind just applying it how you
see fit?)

j.
