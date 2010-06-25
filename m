From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 3/3] Don't expand CRLFs when normalizing text during
 merge
Date: Fri, 25 Jun 2010 10:17:38 +0200
Message-ID: <4C246622.9090707@viscovery.net>
References: <cover.1277408598.git.eyvind.bernhardsen@gmail.com> <90f38b5f5c49f9b9f5427a026e51f867a1121982.1277408598.git.eyvind.bernhardsen@gmail.com> <4C244278.10407@viscovery.net> <FB02F1B0-9FE7-4B7B-BA30-5A510F83BCE7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 10:17:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS46h-0005Ac-7U
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 10:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab0FYIRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 04:17:45 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:19261 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab0FYIRn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 04:17:43 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OS46U-00008g-LV; Fri, 25 Jun 2010 10:17:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 63D411660F;
	Fri, 25 Jun 2010 10:17:38 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <FB02F1B0-9FE7-4B7B-BA30-5A510F83BCE7@gmail.com>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149671>

Am 6/25/2010 9:58, schrieb Eyvind Bernhardsen:
> On 25. juni 2010, at 07.45, Johannes Sixt wrote:
> 
>> Am 6/24/2010 22:44, schrieb Eyvind Bernhardsen:
>>> There's no need to expand CRLFs when convert_to_working_tree() is called
>>> to normalize text for a merge since the text will be converted back
>>> immediately.  Improves performance of merges with conflicting line
>>> endings when core.eol=crlf or core.autocrlf=true.
>>
>> Pardon me, first you make a big deal about normalization for merges, only
>> that you finally omit it? What am I missing?
> 
> Sorry, I didn't explain that very well.  I noticed that normalize_buffer()
> does more work when core.eol=crlf than it does when core.eol=lf:
> _to_working_tree() converts LF to CRLF, and then _to_git() reverses that
> conversion.  This patch makes normalization act the same way when
> core.eol=crlf as it does when core.eol=lf.

Got it: I missed that you are omitting the conversion only on the "way
out" but not on the "way back".

Looking more closely at your patch, I think that you should make this
optimization only if you can prove that the subsequent apply_filter() is a
no-op. Otherwise, you may break a smudge filter that expects CRLFs.

-- Hannes
