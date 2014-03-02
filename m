From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] Replace memcpy with hashcpy when lengths defined
Date: Sun, 2 Mar 2014 19:44:13 -0000
Organization: OPDS
Message-ID: <BD20EE393DBA43E39E6390ECB511EDD2@PhilipOakley>
References: <1393787977-13164-1-git-send-email-albcoron@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Alberto" <albcoron@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 20:44:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKCJU-0008Sh-GN
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 20:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbaCBToP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 14:44:15 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:35644 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751701AbaCBToO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Mar 2014 14:44:14 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: As4YAFuJE1NZ8YSB/2dsb2JhbABagwY7iRi4WgEBAgGBFRd0giAFAQEEAQgBAR0RFggBASYGAgMFAgEDFQwlFAEECBACBgcXBgEHCwgCAQIDAQwEh0QDCQwJxCsNhzSMQ4VBgRQEiROGHocegx+LMYVIgy08
X-IPAS-Result: As4YAFuJE1NZ8YSB/2dsb2JhbABagwY7iRi4WgEBAgGBFRd0giAFAQEEAQgBAR0RFggBASYGAgMFAgEDFQwlFAEECBACBgcXBgEHCwgCAQIDAQwEh0QDCQwJxCsNhzSMQ4VBgRQEiROGHocegx+LMYVIgy08
X-IronPort-AV: E=Sophos;i="4.97,573,1389744000"; 
   d="scan'208";a="446680429"
Received: from host-89-241-132-129.as13285.net (HELO PhilipOakley) ([89.241.132.129])
  by out1.ip05ir2.opaltelecom.net with SMTP; 02 Mar 2014 19:44:10 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243157>

From: "Alberto" <albcoron@gmail.com>
> From: Alberto Corona <albcoron@gmail.com>
>
> Replaced memcpy with hashcpy where lengts in memcpy

s/lengts/lengths/

> are already defined.
>
> Signed-off-by: Alberto Corona <albcoron@gmail.com>
> ---
> bundle.c    | 2 +-
> grep.c      | 2 +-
> refs.c      | 2 +-
> sha1_name.c | 4 ++--
> 4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/bundle.c b/bundle.c
> index e99065c..7809fbb 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -19,7 +19,7 @@ static void add_to_ref_list(const unsigned char 
> *sha1, const char *name,
>  list->list = xrealloc(list->list,
>  list->alloc * sizeof(list->list[0]));
>  }
> - memcpy(list->list[list->nr].sha1, sha1, 20);
> + hashcpy(list->list[list->nr].sha1, sha1);
>  list->list[list->nr].name = xstrdup(name);
>  list->nr++;
> }
> diff --git a/grep.c b/grep.c
> index c668034..f5101f7 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1650,7 +1650,7 @@ void grep_source_init(struct grep_source *gs, 
> enum grep_source_type type,
>  break;
>  case GREP_SOURCE_SHA1:
>  gs->identifier = xmalloc(20);
> - memcpy(gs->identifier, identifier, 20);
> + hashcpy(gs->identifier, identifier);
>  break;
>  case GREP_SOURCE_BUF:
>  gs->identifier = NULL;
> diff --git a/refs.c b/refs.c
> index 89228e2..f90b7ea 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1222,7 +1222,7 @@ static int resolve_gitlink_packed_ref(struct 
> ref_cache *refs,
>  if (ref == NULL)
>  return -1;
>
> - memcpy(sha1, ref->u.value.sha1, 20);
> + hashcpy(sha1, ref->u.value.sha1);
>  return 0;
> }
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 6fca869..3f5010f 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -111,7 +111,7 @@ static void find_short_object_filename(int len, 
> const char *hex_pfx, struct disa
>  continue;
>  if (memcmp(de->d_name, hex_pfx + 2, len - 2))
>  continue;
> - memcpy(hex + 2, de->d_name, 38);
> + hashcpy(hex + 2, de->d_name);
>  if (!get_sha1_hex(hex, sha1))
>  update_candidates(ds, sha1);
>  }
> @@ -373,7 +373,7 @@ const char *find_unique_abbrev(const unsigned char 
> *sha1, int len)
>  static char hex[41];
>
>  exists = has_sha1_file(sha1);
> - memcpy(hex, sha1_to_hex(sha1), 40);
> + hashcpy(hex, sha1_to_hex(sha1));
>  if (len == 40 || !len)
>  return hex;
>  while (len < 40) {
> -- 
> 1.9.0.138.g2de3478.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
