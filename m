From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/7] sha1_file: keep track of where an SHA-1 object comes from
Date: Fri, 25 Jan 2013 11:02:12 +0700
Message-ID: <CACsJy8Dv6jVO2BJpQ3H_f7NEkzuZSYOipsbPatAjciufd3X4qQ@mail.gmail.com>
References: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
 <7va9rycw4t.fsf@alter.siamese.dyndns.org> <CACsJy8Ag6v7wUnupRwGid26AUzgZ=WbdA5F-MpjUv5ktaj5Asg@mail.gmail.com>
 <7v4ni59ano.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 05:03:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyaVM-00055a-GF
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 05:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754935Ab3AYECo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 23:02:44 -0500
Received: from mail-oa0-f41.google.com ([209.85.219.41]:40572 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199Ab3AYECm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 23:02:42 -0500
Received: by mail-oa0-f41.google.com with SMTP id j6so110291oag.28
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 20:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=WIVfNdR+cI0vIJ0z0KSfabvsBoQWDy8ehevnRDKzqCI=;
        b=eUv3TibvMfn0M4pqmDoz8uOr+SRlwTlA7wWiYnySmb7ky/H0vZRCM7/XDZ0KrktFpB
         rIB6vvrDEaBFa77Mufa+ngY1j/xv3M0ocVuAjkIJtYVtVOlvB+TOZM92OzjF+Sk8ZwbX
         aSm/akGALTx52/MurlWKHtYVuLhFmnN330z4bWVAZnJdGiejkIa7grWmsBkL5EKq3rsw
         93ls6KSx4NSk9dL7GcoU1/AHom1c36OSlMxuYEFRCHYUcA9964WnFPzqTChf6Bt1Scx3
         KMF2wWsEm56CYhWMIiXhRIMVg2yer6LQnhZgFL1MwqU/kaCCAiWRINP+4oB2hS6NS4Kc
         nirQ==
X-Received: by 10.182.131.3 with SMTP id oi3mr3365267obb.84.1359086562385;
 Thu, 24 Jan 2013 20:02:42 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Thu, 24 Jan 2013 20:02:12 -0800 (PST)
In-Reply-To: <7v4ni59ano.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214485>

On Fri, Jan 25, 2013 at 10:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Fri, Jan 25, 2013 at 12:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>  How about this way instead: we keep track of where objects come from
>>>>  so we can verify object source when we create or update something
>>>>  that contains SHA-1.
>>>
>>> The overall approach taken by this series may be worth considering, but
>>> I do not think the check implemented here is correct.
>>>
>>> An object may be found in an alternate odb but we may also have our
>>> own copy of the same object.  You need to prove that a suspicious
>>> object is visible to us *ONLY* through add_submodule_odb().
>>
>> The way alt odbs are linked (new odbs area always at the end), if we
>> have the same copy, their copy will never be read (we check out alt
>> odbs from head to tail). So those duplicate suspicious objects are
>> actually invisible to us.
>
> The way I read find_pack_entry() is that our heuristics to start
> our search by looking at the pack in which we found an object the
> last time will invalidate your assumption above.  Am I mistaken?

No, you are right. Loose objects are always searched from the start of
alt odb list. Packs are searched till the end then back to head again.
-- 
Duy
