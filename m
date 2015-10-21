From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 17/34] mailinfo: move use_scissors and use_inbody_headers to struct mailinfo
Date: Wed, 21 Oct 2015 14:02:18 -0700
Message-ID: <xmqq8u6wue91.fsf@gitster.mtv.corp.google.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-18-git-send-email-gitster@pobox.com>
	<CAGZ79kZkms9SS3YpyEK4tmUPZ3TwXRF1M30X58GrS8dV13rJng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 23:02:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zp0Wg-0004tF-U4
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 23:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755247AbbJUVCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 17:02:22 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751876AbbJUVCV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 17:02:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 86375254C9;
	Wed, 21 Oct 2015 17:02:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eK7/GDaxTLBWO7+M3Z3a1hmdGug=; b=k0CoYs
	iof+bLO0cunLf7fo1KQPdE+DovilT743QTVXA7gF2dpf/xPbMu0Ixs6KWUTonp98
	AMQ6rZJn7bQUg2IYWVBfyLCAICZjPrsd0KM7Ncs1Bi1SHpnhdd997W+1hAmYTGVJ
	Ye0ijKEN5t3y5CfwaP6DNQhFDXk9XW3/l9/3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lsr+NtsNLYkywhwbybQdJoJ0AklL34z2
	Dl13SWsNcu9wGgWaECRIknIcPuSZl2qukXGY+rD23P0c4IhUmDPGe7m8+9KDWO8L
	BELBfUcnhMCK9wdu49wu85AXPDdt3tZlFPBVxP41AtaKehaK3mPjJkdrMTY79q4T
	8H9lB737w/8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F02D254C8;
	Wed, 21 Oct 2015 17:02:20 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0149F254C6;
	Wed, 21 Oct 2015 17:02:19 -0400 (EDT)
In-Reply-To: <CAGZ79kZkms9SS3YpyEK4tmUPZ3TwXRF1M30X58GrS8dV13rJng@mail.gmail.com>
	(Stefan Beller's message of "Wed, 21 Oct 2015 13:24:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0496948A-7837-11E5-AACB-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280019>

Stefan Beller <sbeller@google.com> writes:

> On Mon, Oct 19, 2015 at 12:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  builtin/mailinfo.c | 23 +++++++++++++----------
>>  1 file changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
>> index c0522f2..2c8f249 100644
>> --- a/builtin/mailinfo.c
>> +++ b/builtin/mailinfo.c
>> @@ -20,6 +20,8 @@ struct mailinfo {
>>         int keep_subject;
>>         int keep_non_patch_brackets_in_subject;
>>         int add_message_id;
>> +       int use_scissors;
>> +       int use_inbody_headers; /* defaults to 1 */
>
> IMHO there is no need for the comment here, stating its default.
> That can be looked up in the init function, which is as convenient as
> reading globals in a file?

It was crucial to ensure correctness during conversion, that is, a
conversion done in

 (1) Remove "static int use_inbody_headers = 1"
 (2) Add "int use_inbody_headers;"
 (3) Update setup_mailinfo()

sequence would have lost a clue as to what the right value to assign
in step (3).  Tweaking (2) to leave "/* this starts at 1 */" helped
avoid such a mistake.

When reading the end result, the above three appear to have been
done simultaneously, so I agree that the comment does not help.
