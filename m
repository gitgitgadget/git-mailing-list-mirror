From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [RFC/PATCH] Make --full-history consider more merges
Date: Thu, 25 Apr 2013 20:11:16 +0300
Message-ID: <517963B4.30801@bracey.fi>
References: <7v4nfcj2kq.fsf@alter.siamese.dyndns.org> <1366658602-12254-1-git-send-email-kevin@bracey.fi> <7vzjwqny64.fsf@alter.siamese.dyndns.org> <5176B854.2000707@bracey.fi> <7va9ona77d.fsf@alter.siamese.dyndns.org> <7v61zb8j5d.fsf@alter.siamese.dyndns.org> <5179505F.2000108@bracey.fi> <7vtxmu4kq2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 19:49:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVQIG-0002ay-Ig
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 19:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933116Ab3DYRtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 13:49:12 -0400
Received: from 16.mo1.mail-out.ovh.net ([178.33.104.224]:56776 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932737Ab3DYRtL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 13:49:11 -0400
Received: from mail425.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id 2632CFF90FE
	for <git@vger.kernel.org>; Thu, 25 Apr 2013 19:11:19 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 25 Apr 2013 19:11:36 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 25 Apr 2013 19:11:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.1 (mo1.mail-out.ovh.net)
In-Reply-To: <7vtxmu4kq2.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 7189433856946639064
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrgeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.500658/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrgeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222400>

On 25/04/2013 19:51, Junio C Hamano wrote:
> Kevin Bracey <kevin@bracey.fi> writes:
>
>> Thanks for the test addition. Maybe we will be able to satisfy your
>> greed in this series. There could be more worth doing here, and I
>> think getting TREESAME precise is key.
> It is perfectly fine to do things one step at a time.  Let's get
> the --full-history change into a good shape first and worry about
> the more complex case after we are done.

So do you see the rerun of try_to_simplify_commit() as acceptable? I'm 
really not happy with it - it was fine for an initial proof-of-concept, 
but it's an obvious waste of CPU cycles to recompute something we 
already figured out, and I'm uncomfortable with the fact that the 
function potentially does more than just compute TREESAME; by inspection 
it seems safe given the known context inside simplify_merges(), but it 
feels like something waiting to trip us up. The latter could be dealt 
with by breaking try_to_simplify_commit() up, but that feels like a 
diversion. I'd rather just get on and make this first patch store and 
use the per-parent-treesame flags if feasible.

Kevin
