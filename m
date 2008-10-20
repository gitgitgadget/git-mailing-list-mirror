From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: [PATCH] fix multiple issues in index-pack
Date: Mon, 20 Oct 2008 22:59:25 +0200
Message-ID: <20081020205925.GA25524@fiberbit.xs4all.nl>
References: <alpine.LFD.2.00.0810201609300.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 00:21:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks1s1-0006ok-OC
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 23:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbYJTU7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 16:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752732AbYJTU7p
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 16:59:45 -0400
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:2266 "EHLO
	smtp-vbr16.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbYJTU7o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 16:59:44 -0400
Received: from fiberbit.xs4all.nl (fiberbit.xs4all.nl [80.101.187.211])
	by smtp-vbr16.xs4all.nl (8.13.8/8.13.8) with ESMTP id m9KKxQox080042;
	Mon, 20 Oct 2008 22:59:26 +0200 (CEST)
	(envelope-from marco.roeland@xs4all.nl)
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.69)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1Ks1qX-0006f7-Rf; Mon, 20 Oct 2008 22:59:25 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810201609300.26244@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98725>

On Monday October 20th 2008 at 16:46 Nicolas Pitre wrote:

> Since commit 9441b61dc5, two issues affected correct behavior of 
> index-pack:
> 
>  1) The real_type of a delta object is the 'real_type' of its base, not
>     the 'type' which can be a "delta type".  Consequence of this is a
>     corrupted pack index file which only needs to be recreated with a 
>     good index-pack command ('git verify-pack' will flag those).
> 
>  2( The code sequence:
> 
>         result->data = patch_delta(get_base_data(base), base->obj->size,
>                                    delta_data, delta_size, &result->size);
> 
>     has two issues of its own since base->obj->size should instead be
>     base->size as we want the size of the actual object data and not
>     the size of the delta object it is represented by.  Except that 
>     simply replacing base->obj->size with base->size won't make the
>     code more correct as the C language doesn't enforce a particular 
>     ordering for the evaluation of needed arguments for a function call,
>     hence base->size could be pushed on the stack before get_base_data()
>     which initializes base->size is called.
> 
> Signed-off-by: Nicolas Pitre <nico@cam.org>

This patch works for me. Thanks and good detective work.
-- 
Marco Roeland
