From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add the --submodule-summary option to the diff option
   family
Date: Mon, 05 Oct 2009 11:09:23 +0200
Message-ID: <4AC9B7C3.3090302@viscovery.net>
References: <cover.1254668669u.git.johannes.schindelin@gmx.de> <67a884457aeaead275612be10902a80726b2a7db.1254668669u.git.johannes.schindelin@gmx.de> <7vbpkmn6oi.fsf@alter.siamese.dyndns.org> <4AC98FC8.3090202@viscovery.net> <alpine.DEB.1.00.0910051057350.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 05 11:15:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MujfQ-0000Rr-IS
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 11:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbZJEJKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 05:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758714AbZJEJKE
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 05:10:04 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:10302 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758171AbZJEJKD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 05:10:03 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MujZL-0001sG-VB; Mon, 05 Oct 2009 11:09:24 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 84835BC81; Mon,  5 Oct 2009 11:09:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.DEB.1.00.0910051057350.4985@pacific.mpi-cbg.de>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129539>

Johannes Schindelin schrieb:
> On Mon, 5 Oct 2009, Johannes Sixt wrote:
>> Junio C Hamano schrieb:
>>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>>> +	fwrite(sb.buf, sb.len, 1, f);
>>>> +
>>>> +	if (!message) {
>>>> +		while ((commit = get_revision(&rev))) {
>>>> +			strbuf_setlen(&sb, 0);
>>>> +			if (del)
>>>> +				strbuf_addstr(&sb, commit->object.flags &
>>>> +						SYMMETRIC_LEFT ? del : add);
>>>> +			format_commit_message(commit, format, &sb,
>>>> +					rev.date_mode);
>>>> +			if (del)
>>>> +				strbuf_addstr(&sb, reset);
>>>> +			strbuf_addch(&sb, '\n');
>>>> +			fwrite(sb.buf, sb.len, 1, f);
>> Outch! fwrite doesn't interpret color escapes. AFAICS, this sequence is
>> easy to change such that it uses fprintf().
> 
> Good point.  I changed it to
> 
>                         fprintf(f, "%s", sb.buf);

Thanks. But notice how you are constructing the string in sb from pieces.
I meant to change it to

	fprintf(f, "%s%s%s\n",
			del ? (commit->object.flags & SYMMETRIC_LEFT
					 ? del : add) : "",
			format_commit_message(commit, format, &sb,
					rev.date_mode),
			del ? reset : "");

or similar. We already use this idiom elsewhere.

-- Hannes
