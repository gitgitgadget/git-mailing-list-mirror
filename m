From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH] Fix sizeof usage in get_permutations
Date: Thu, 13 Dec 2012 17:13:49 +0100
Message-ID: <kacus2$mml$1@ger.gmane.org>
References: <1355405790-20302-1-git-send-email-mattjd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 17:14:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjBQj-0004Sf-UI
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 17:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756074Ab2LMQOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 11:14:21 -0500
Received: from plane.gmane.org ([80.91.229.3]:42431 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755733Ab2LMQOU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 11:14:20 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TjBQb-0004FU-Jf
	for git@vger.kernel.org; Thu, 13 Dec 2012 17:14:29 +0100
Received: from dsdf-4d0a151d.pool.mediaways.net ([77.10.21.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Dec 2012 17:14:29 +0100
Received: from jojo by dsdf-4d0a151d.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Dec 2012 17:14:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4d0a151d.pool.mediaways.net
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211457>

Matthew Daley wrote:
> Currently it gets the size of an otherwise unrelated, unused variable
> instead of the expected struct size.
> 
> Signed-off-by: Matthew Daley <mattjd@gmail.com>
> ---
> builtin/pack-redundant.c |    6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
> index f5c6afc..7544687 100644
> --- a/builtin/pack-redundant.c
> +++ b/builtin/pack-redundant.c
> @@ -301,14 +301,14 @@ static void pll_free(struct pll *l)
>  */
> static struct pll * get_permutations(struct pack_list *list, int n)
> {
> - struct pll *subset, *ret = NULL, *new_pll = NULL, *pll;
> + struct pll *subset, *ret = NULL, *new_pll = NULL;
> 
>  if (list == NULL || pack_list_size(list) < n || n == 0)
>  return NULL;
> 
>  if (n == 1) {
>  while (list) {
> - new_pll = xmalloc(sizeof(pll));
> + new_pll = xmalloc(sizeof(struct pll));
>  new_pll->pl = NULL;
>  pack_list_insert(&new_pll->pl, list);
>  new_pll->next = ret;
> @@ -321,7 +321,7 @@ static struct pll * get_permutations(struct
>  pack_list *list, int n) while (list->next) {
>  subset = get_permutations(list->next, n - 1);
>  while (subset) {
> - new_pll = xmalloc(sizeof(pll));
> + new_pll = xmalloc(sizeof(struct pll));

Why not just
new_pll = xmalloc(sizeof(*new_pll));

>  new_pll->pl = subset->pl;
>  pack_list_insert(&new_pll->pl, list);
>  new_pll->next = ret;
