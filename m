From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFC/PATCH 1/3] revision.c: tighten up TREESAME handling of merges
Date: Sat, 27 Apr 2013 15:57:41 -0700
Message-ID: <CAJDDKr7-cOz2R31Gq_45Wu70YXiHQOcCTwVVGDjQK3np2+53og@mail.gmail.com>
References: <517AD304.6020807@bracey.fi>
	<1367004718-30048-1-git-send-email-kevin@bracey.fi>
	<7vppxfsirl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Bracey <kevin@bracey.fi>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 28 00:57:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWE3w-0004Dy-HR
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 00:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178Ab3D0W5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 18:57:43 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:44132 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835Ab3D0W5n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 18:57:43 -0400
Received: by mail-wi0-f169.google.com with SMTP id h11so1862198wiv.4
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 15:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=agzxLNsCG9vSHYPlOAq5XUgdxqsqyoqzeKQxerirzR0=;
        b=TN601eAOuH30pVDTeBc5fdHKHXN83BPPB0QkrWlWiklcZFpZ0x3qYwURF2PPwKGur6
         JJZD5n3pVoRLnHqv8fDQV6U2DpJ5vC6BglicnpWqbTLSkpDUSk972vfW2u5bOXQusHW9
         zjIIEtZLvrvG79FGyi7C9UbXxHZjlASXMRsKIw4vXPuCTxLjx8y73tthiihfprOnYFbu
         O5nmUN+ZlG/poHD9RFVMjfK+WeguUNQWECANxKqlPB5vziHxFzxJkM9+5y2f9Js2oIIG
         ijC9vntOGssUca6OJmLFhKCuiVce94NRFwTDVsoZz3lj/qg92PnN7HsPxpfXb3r1J44z
         F1pw==
X-Received: by 10.194.122.131 with SMTP id ls3mr31670667wjb.55.1367103461891;
 Sat, 27 Apr 2013 15:57:41 -0700 (PDT)
Received: by 10.194.240.195 with HTTP; Sat, 27 Apr 2013 15:57:41 -0700 (PDT)
In-Reply-To: <7vppxfsirl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222712>

On Sat, Apr 27, 2013 at 3:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Kevin Bracey <kevin@bracey.fi> writes:
>> diff --git a/revision.c b/revision.c
>> index a67b615..176eb7b 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -1971,6 +2066,70 @@ static struct merge_simplify_state *locate_simplify_state(struct rev_info *revs,
>>       return st;
>>  }
>>
>> +static int mark_redundant_parents(struct rev_info *revs, struct commit *commit)
>> +{
>> +     struct commit_list *h = reduce_heads(commit->parents);
>> +     int i = 0, marked = 0;
>> +     struct commit_list *po, *pn;
>> +
>> +     /* Want these for sanity only */
>> +     int orig_cnt = commit_list_count(commit->parents);
>> +     int cnt = commit_list_count(h);
>> +
>> +     /* Not ready to remove items yet, just mark them for now, based
>
> (same style on "/*")
>
>> +      * on the output of reduce_heads(). reduce_heads outputs the reduced
>> +      * set in its original order, so this isn't too hard.
>> +      */
>> +     po = commit->parents;
>> +     pn = h;
>> +     while (po) {
>> +             if (pn && po->item == pn->item) {
>> +                     pn=pn->next;
>
> (style) SPs before and after '='.
>
>> +                     i++;
>> +             }
>> +             else {

(style) cuddle this } else { block.
--
David
