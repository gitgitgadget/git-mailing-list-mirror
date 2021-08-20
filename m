Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA5AC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CBE66115C
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhHTRoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 13:44:03 -0400
Received: from mout.web.de ([212.227.17.12]:50915 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229940AbhHTRoC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 13:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1629481387;
        bh=qw1jhYuNZHnAHDhehq6VgBLOxadBhTp1UfeGopNQkzw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=W5/UEQMRdd7LuFTUl3vLVmyynmKbOf3qbvtqNe4Y6O9U82b97ieSe1a8blAYoYnqD
         RbodPhGbicgEamtp9+msuSy+JZFObuc24yZ0c6lM5icWp125PSqkfvTSeqp9c0sqwa
         00w7WSj3FmwXn/hIkO6pGV+ncAFRuBR35dhHslas=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LlF9O-1moYM10jqw-00b0z3; Fri, 20 Aug 2021 19:43:07 +0200
Subject: Re: [PATCH 3/6] connected: refactor iterator to return next object ID
 directly
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1629452412.git.ps@pks.im>
 <3bdad7bc8b0debd44138a4d3df5744d5a245475d.1629452412.git.ps@pks.im>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5f9e7a4f-d95b-4242-1add-7b20057293a3@web.de>
Date:   Fri, 20 Aug 2021 19:43:06 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3bdad7bc8b0debd44138a4d3df5744d5a245475d.1629452412.git.ps@pks.im>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6NtOGPWEfJYMu7/VPApaDrpMFEx0FZrNdgLgE7tLb4bGND95lHM
 m3l3mVRXHCjCZQwXww9f+AtQufvKEOOOv0OwFkXWVSviUpl7/eyID6bgetoTs1MHciTlmot
 sca8zI0NJE8FZ4xPS5l5bfG/PRW3Udk7qx4gXsFMbG/GEtEslUp4OzMB/nwx5pMZFdkYiDO
 svNDy+6F2l5yjeWMeAz+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GwRS7cXLJ1o=:NvMWUH/ertc+OuOYp+/iOR
 br1ISOvNcJEKhaNjz+WRigTm2Kc3vcCepESOno53oxkoLrlsur60hRweprbsr5dzQv9c0tjeC
 vwEDpleolkP9NPzkkB205FBex0/HDBMWCt7IsDz+im6noBe/iKNCY3pAtdL8utpInacYg5ryS
 WWKkNss9ntN3yh3Jt6lM/QDCSGsPi+9IBKR9ylJFiq+gE4N/PtSiCreZC10knuSal9zVjzkMp
 qcAVZmZSmOY1hsjtp2MEb34nGX2K8lzKgdAs8vVSJGQspPdiHY35u/sB59LHp2jyc66XaowvL
 Ku2l+NGteuPGw1+PT70bTPQMUlFX38OqEHLxNPn1nJg++b+6bHyWtpnU1Cr17XfHD1wSfjZFK
 y5C5CJeO/n5PDF1cY/6GqMQnSof9W7ZeM3Ccms0mqgiZoqK7X8nF01SD9tokmQHhHkOGgjxnW
 a4mQdG4D1Ow0Vo4MdkOD+q3hbIpq5+UurW49AZIidDHZr6xRgWx58laSYM27M83W5uWHtHA13
 6eW1WMuCtRlF2lKidvHiUOwpF1NAqbAIR1m21UEb8+2u/MHC8j/AYuQK1T+eQjYOGH4McU6Hs
 1dkq/j5j7gw1QT6k+lYGVqF+S4oOfPagE/q8HqZcU+8GbS5wQ9Ep66WXEqj0vb94CVjQeERlB
 ojB2JiFxI6owWC4ymxgRy0gQB0LELfNRpM/tKft9zClBouOjhVXGBrFTXBBsxBHh8X54dfdop
 oQw/xnwVWsj+cRFMl5RClZN32FnjdlKOIJWW/7R8gaf51pKglKevIcjL7AvtB4bty/elRgEvm
 9MWOkJqqGoXZUCBecJuHaYd70+kHRYRUoeohSVCxFW5aljzy1nK+yrV1TziLu8+AO/nr0w6AS
 q35mnUI9nyR2yjMg/yq8ZS+ApsfuB2kk80X9iNj+UxdfzDZSObddrLubRJhzvhQoCn490izWj
 XpcdSlyOo6TcU9WqeQek9ZP2i4WoZiXvE9sblRGaI+diastyaka7UOyNxNkkJEPver/EP5LTp
 /zx0ulwFku+pqImHgvPJZCW7FjLhftQZDzFr2P73WLMuupSzVAfQuNEUzzumRVkhgHbJFZrVk
 dVJ67s+cLN1T60DR4igkFxy6783rtGHo5cz
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.08.21 um 12:08 schrieb Patrick Steinhardt:
> The object ID iterator used by the connectivity checks returns the next
> object ID via an out-parameter and then uses a return code to indicate
> whether an item was found. This is a bit roundabout: instead of a
> separate error code, we can just retrun the next object ID directly and

s/retrun/return/

> use `NULL` pointers as indicator that the iterator got no items left.
> Furthermore, this avoids a copy of the object ID.
>
> Refactor the iterator and all its implementations to return object IDs
> directly. While I was honestly hoping for a small speedup given that we
> can now avoid a copy, both versions perform the same. Still, the end
> result is easier to understand and thus it makes sense to keep this
> refactoring regardless.

check_connected() calls find_pack_entry_one() on the object ID hash,
which copies it anyway.  Perhaps that and caching prevent the expected
speedup?

The private copy made sure check_connected() could not modify the
object IDs.  It still only reads them with this patch, but the compiler
no longer prevents writes.  The iterators could return const pointers
to restore that guarantee.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/clone.c        |  8 +++-----
>  builtin/fetch.c        |  7 +++----
>  builtin/receive-pack.c | 17 +++++++----------
>  connected.c            | 15 ++++++++-------
>  connected.h            |  2 +-
>  fetch-pack.c           |  7 +++----
>  6 files changed, 25 insertions(+), 31 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index a74558f30c..817a651936 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -544,7 +544,7 @@ static void write_followtags(const struct ref *refs,=
 const char *msg)
>  	}
>  }
>
> -static int iterate_ref_map(void *cb_data, struct object_id *oid)
> +static struct object_id *iterate_ref_map(void *cb_data)
>  {
>  	struct ref **rm =3D cb_data;
>  	struct ref *ref =3D *rm;
> @@ -555,13 +555,11 @@ static int iterate_ref_map(void *cb_data, struct o=
bject_id *oid)
>  	 */
>  	while (ref && !ref->peer_ref)
>  		ref =3D ref->next;
> -	/* Returning -1 notes "end of list" to the caller. */
>  	if (!ref)
> -		return -1;
> +		return NULL;
>
> -	oidcpy(oid, &ref->old_oid);
>  	*rm =3D ref->next;
> -	return 0;
> +	return &ref->old_oid;
>  }
>
>  static void update_remote_refs(const struct ref *refs,
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 5fd0f7c791..76ce73ccf5 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -962,7 +962,7 @@ static int update_local_ref(struct ref *ref,
>  	}
>  }
>
> -static int iterate_ref_map(void *cb_data, struct object_id *oid)
> +static struct object_id *iterate_ref_map(void *cb_data)
>  {
>  	struct ref **rm =3D cb_data;
>  	struct ref *ref =3D *rm;
> @@ -970,10 +970,9 @@ static int iterate_ref_map(void *cb_data, struct ob=
ject_id *oid)
>  	while (ref && ref->status =3D=3D REF_STATUS_REJECT_SHALLOW)
>  		ref =3D ref->next;
>  	if (!ref)
> -		return -1; /* end of the list */
> +		return NULL;
>  	*rm =3D ref->next;
> -	oidcpy(oid, &ref->old_oid);
> -	return 0;
> +	return &ref->old_oid;
>  }
>
>  struct fetch_head {
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index a419de5b38..0abda033bc 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1307,7 +1307,7 @@ static void refuse_unconfigured_deny_delete_curren=
t(void)
>  	rp_error("%s", _(refuse_unconfigured_deny_delete_current_msg));
>  }
>
> -static int command_singleton_iterator(void *cb_data, struct object_id *=
oid);
> +static struct object_id *command_singleton_iterator(void *cb_data);
>  static int update_shallow_ref(struct command *cmd, struct shallow_info =
*si)
>  {
>  	struct shallow_lock shallow_lock =3D SHALLOW_LOCK_INIT;
> @@ -1725,16 +1725,15 @@ static void check_aliased_updates(struct command=
 *commands)
>  	string_list_clear(&ref_list, 0);
>  }
>
> -static int command_singleton_iterator(void *cb_data, struct object_id *=
oid)
> +static struct object_id *command_singleton_iterator(void *cb_data)
>  {
>  	struct command **cmd_list =3D cb_data;
>  	struct command *cmd =3D *cmd_list;
>
>  	if (!cmd || is_null_oid(&cmd->new_oid))
> -		return -1; /* end of list */
> +		return NULL;
>  	*cmd_list =3D NULL; /* this returns only one */
> -	oidcpy(oid, &cmd->new_oid);
> -	return 0;
> +	return &cmd->new_oid;
>  }
>
>  static void set_connectivity_errors(struct command *commands,
> @@ -1764,7 +1763,7 @@ struct iterate_data {
>  	struct shallow_info *si;
>  };
>
> -static int iterate_receive_command_list(void *cb_data, struct object_id=
 *oid)
> +static struct object_id *iterate_receive_command_list(void *cb_data)
>  {
>  	struct iterate_data *data =3D cb_data;
>  	struct command **cmd_list =3D &data->cmds;
> @@ -1775,13 +1774,11 @@ static int iterate_receive_command_list(void *cb=
_data, struct object_id *oid)
>  			/* to be checked in update_shallow_ref() */
>  			continue;
>  		if (!is_null_oid(&cmd->new_oid) && !cmd->skip_update) {
> -			oidcpy(oid, &cmd->new_oid);
>  			*cmd_list =3D cmd->next;
> -			return 0;
> +			return &cmd->new_oid;
>  		}
>  	}
> -	*cmd_list =3D NULL;
> -	return -1; /* end of list */
> +	return NULL;
>  }
>
>  static void reject_updates_to_hidden(struct command *commands)
> diff --git a/connected.c b/connected.c
> index b5f9523a5f..374b145355 100644
> --- a/connected.c
> +++ b/connected.c
> @@ -24,7 +24,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  	struct child_process rev_list =3D CHILD_PROCESS_INIT;
>  	FILE *rev_list_in;
>  	struct check_connected_options defaults =3D CHECK_CONNECTED_INIT;
> -	struct object_id oid;
> +	struct object_id *oid;
>  	int err =3D 0;
>  	struct packed_git *new_pack =3D NULL;
>  	struct transport *transport;
> @@ -34,7 +34,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  		opt =3D &defaults;
>  	transport =3D opt->transport;
>
> -	if (fn(cb_data, &oid)) {
> +	oid =3D fn(cb_data);
> +	if (!oid) {
>  		if (opt->err_fd)
>  			close(opt->err_fd);
>  		return err;
> @@ -73,7 +74,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  			for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
>  				if (!p->pack_promisor)
>  					continue;
> -				if (find_pack_entry_one(oid.hash, p))
> +				if (find_pack_entry_one(oid->hash, p))
>  					goto promisor_pack_found;
>  			}
>  			/*
> @@ -83,7 +84,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  			goto no_promisor_pack_found;
>  promisor_pack_found:
>  			;
> -		} while (!fn(cb_data, &oid));
> +		} while ((oid =3D fn(cb_data)) !=3D NULL);
>  		return 0;
>  	}
>
> @@ -133,12 +134,12 @@ int check_connected(oid_iterate_fn fn, void *cb_da=
ta,
>  		 * are sure the ref is good and not sending it to
>  		 * rev-list for verification.
>  		 */
> -		if (new_pack && find_pack_entry_one(oid.hash, new_pack))
> +		if (new_pack && find_pack_entry_one(oid->hash, new_pack))
>  			continue;
>
> -		if (fprintf(rev_list_in, "%s\n", oid_to_hex(&oid)) < 0)
> +		if (fprintf(rev_list_in, "%s\n", oid_to_hex(oid)) < 0)
>  			break;
> -	} while (!fn(cb_data, &oid));
> +	} while ((oid =3D fn(cb_data)) !=3D NULL);
>
>  	if (ferror(rev_list_in) || fflush(rev_list_in)) {
>  		if (errno !=3D EPIPE && errno !=3D EINVAL)
> diff --git a/connected.h b/connected.h
> index 8d5a6b3ad6..56cc95be2d 100644
> --- a/connected.h
> +++ b/connected.h
> @@ -9,7 +9,7 @@ struct transport;
>   * When called after returning the name for the last object, return -1
>   * to signal EOF, otherwise return 0.
>   */
> -typedef int (*oid_iterate_fn)(void *, struct object_id *oid);
> +typedef struct object_id *(*oid_iterate_fn)(void *);

I.e. this would be safer (requires some more const modifiers throughout
the code):

typedef const struct object_id * (*oid_iterate_fn)(void *);

>
>  /*
>   * Named-arguments struct for check_connected. All arguments are
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 0bf7ed7e47..1a6242cd71 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1912,16 +1912,15 @@ static void update_shallow(struct fetch_pack_arg=
s *args,
>  	oid_array_clear(&ref);
>  }
>
> -static int iterate_ref_map(void *cb_data, struct object_id *oid)
> +static struct object_id *iterate_ref_map(void *cb_data)
>  {
>  	struct ref **rm =3D cb_data;
>  	struct ref *ref =3D *rm;
>
>  	if (!ref)
> -		return -1; /* end of the list */
> +		return NULL;
>  	*rm =3D ref->next;
> -	oidcpy(oid, &ref->old_oid);
> -	return 0;
> +	return &ref->old_oid;
>  }
>
>  struct ref *fetch_pack(struct fetch_pack_args *args,
>

