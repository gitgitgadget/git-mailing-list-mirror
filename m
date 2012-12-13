From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Fix sizeof usage in get_permutations
Date: Thu, 13 Dec 2012 16:09:53 -0600
Message-ID: <CAMP44s06jjsxKVk_fVb7dadiZ=d2XavrLT2DRhqOPG2XwmcoMQ@mail.gmail.com>
References: <1355405790-20302-1-git-send-email-mattjd@gmail.com>
	<kacus2$mml$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Thu Dec 13 23:10:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjGyr-0003hn-JY
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 23:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170Ab2LMWJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 17:09:56 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44910 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755962Ab2LMWJx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 17:09:53 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so2626250obb.19
        for <git@vger.kernel.org>; Thu, 13 Dec 2012 14:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pxuIcXloQWZWaicYDbWamfIjTI+0CMn/Ix4fzfPJoqg=;
        b=E4m6PUisY8VOMFUKi8NW9BfRIAnElcYyZgDT3nq4YP8xAmG7LCBWrnYLzhyne2SyP+
         +TteRZWmuJIgyh1G3eYEY1Hl3YBw/nj0sllA6sww3Z5ch4XouNcKSUty8qG8Ps+FBuAD
         KngEyE31JlZhfQZpFIl+gNVFvaPmWAPQ0x1mVK5BYkccMmHBuslQ67fPiuIUjS2hMuQk
         qUAanyvOyVzVj7PaC9NTDJvhTSMEAm/wRviTpiWAtReZh71xGEDDG+WWguS7Gw9uVLi2
         p6RbkCruE9PPFkJef4YM3syY8K1bREDxkXqHl/hB9/+Dgr4Pqj5i5q+qt4VfiD67skky
         8cbw==
Received: by 10.60.31.131 with SMTP id a3mr2847437oei.93.1355436593124; Thu,
 13 Dec 2012 14:09:53 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Thu, 13 Dec 2012 14:09:53 -0800 (PST)
In-Reply-To: <kacus2$mml$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211475>

On Thu, Dec 13, 2012 at 10:13 AM, Joachim Schmitz
<jojo@schmitz-digital.de> wrote:
> Matthew Daley wrote:
>>
>> Currently it gets the size of an otherwise unrelated, unused variable
>> instead of the expected struct size.
>>
>> Signed-off-by: Matthew Daley <mattjd@gmail.com>
>> ---
>> builtin/pack-redundant.c |    6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
>> index f5c6afc..7544687 100644
>> --- a/builtin/pack-redundant.c
>> +++ b/builtin/pack-redundant.c
>> @@ -301,14 +301,14 @@ static void pll_free(struct pll *l)
>>  */
>> static struct pll * get_permutations(struct pack_list *list, int n)
>> {
>> - struct pll *subset, *ret = NULL, *new_pll = NULL, *pll;
>> + struct pll *subset, *ret = NULL, *new_pll = NULL;
>>
>>  if (list == NULL || pack_list_size(list) < n || n == 0)
>>  return NULL;
>>
>>  if (n == 1) {
>>  while (list) {
>> - new_pll = xmalloc(sizeof(pll));
>> + new_pll = xmalloc(sizeof(struct pll));
>>  new_pll->pl = NULL;
>>  pack_list_insert(&new_pll->pl, list);
>>  new_pll->next = ret;
>> @@ -321,7 +321,7 @@ static struct pll * get_permutations(struct
>>  pack_list *list, int n) while (list->next) {
>>  subset = get_permutations(list->next, n - 1);
>>  while (subset) {
>> - new_pll = xmalloc(sizeof(pll));
>> + new_pll = xmalloc(sizeof(struct pll));
>
>
> Why not just
> new_pll = xmalloc(sizeof(*new_pll));

I prefer that one; it's Linux kernel style.

-- 
Felipe Contreras
