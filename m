From: Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH v2 1/3] diffcore-pickaxe: remove unnecessary call to
 get_textconv()
Date: Fri, 5 Apr 2013 15:20:33 +0200
Message-ID: <20130405132033.GB23017@ruderich.org>
References: <7vr4iqi2uw.fsf@alter.siamese.dyndns.org>
 <ed31727421dc3000e943e62a8d82ac1af6589733.1365105971.git.simon@ruderich.org>
 <7vvc82ggy3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:12:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWHl-0002u6-Vm
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161612Ab3DENUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 09:20:35 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:59865 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161475Ab3DENUf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 09:20:35 -0400
Received: from localhost (pD9E96A4A.dip.t-dialin.net [::ffff:217.233.106.74])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Fri, 05 Apr 2013 15:20:33 +0200
  id 0000000000000052.00000000515ECFA1.000067B6
Content-Disposition: inline
In-Reply-To: <7vvc82ggy3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220196>

On Thu, Apr 04, 2013 at 01:48:52PM -0700, Junio C Hamano wrote:
> If I am reading the code correctly, it is has_changes(), which is
> used for "log -S" (not "log -G" that uses diff_grep()), that does
> the unnecessary get_textconv() unconditionally.  The way diff_grep()
> divides the work to make fill_one() responsible for filling the
> textconv as necessary is internally consistent, and there is no
> unnecessary call.

Yes, of course. I meant has_changes() which has the unnecessary
call.

> Perhaps...
>
> 	The fill_one() function is responsible for finding and
> 	filling the textconv filter as necessary, and is called by
> 	diff_grep() function that implements "git log -G<pattern>".
>
> 	The has_changes() function calls get_textconv() for two
> 	sides being compared, before it checks to see if it was
> 	asked to perform the pickaxe limiting with the -S option.
> 	Move the code around to avoid this wastage.  After that,
> 	fill_one() is called to use the textconv.
>
> 	By adding get_textconv() to diff_grep() and relieving
> 	fill_one() of responsibility to find the textconv filter, we
> 	can avoid calling get_textconv() twice.

Sounds good to me.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
