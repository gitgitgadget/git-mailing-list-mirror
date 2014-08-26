From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Transaction patch series overview
Date: Tue, 26 Aug 2014 15:14:48 -0700
Message-ID: <20140826221448.GY20185@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140826000354.GW20185@google.com>
 <xmqqlhqbge3a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 00:15:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMP1s-00035K-Um
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 00:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900AbaHZWOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 18:14:55 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:56244 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755620AbaHZWOw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 18:14:52 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so23309584pde.11
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 15:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=z0so2f2rz4CHwFr1M9o88kgwDp+1JE85LBCeOEqj4Mg=;
        b=tMzDu4IOSBuuJTh4PSyE2I/NClYJhtwcif9C3b8YPJTenVBgSObzHaBSBReJF1Ryjq
         g115sIG3ibzeXQ56rXR8DVCQL6HRgBMNUrDKZ7rGiMsvNEJISuVrnrBMBHWe10A7pWVG
         rCU21JSiU9utUPTLovUdJlNrOpxxXDYoOphXZNBbTLmxtl/zo/3VWIY02fjI+JxF3jb3
         RackAVWDdW5wAnzNjq/bgjevUPXeXn07pmG7SYNjY8gYUllUapAisspM2Exw85Xsbo5T
         ayozyM7ot63uzTOWdLaWm7Nqs2JfsKLvm+YfG4VVFrsOw9NqM0jvoyBUvHMNcPM4pn1L
         ovdA==
X-Received: by 10.66.251.170 with SMTP id zl10mr39995721pac.97.1409091291445;
        Tue, 26 Aug 2014 15:14:51 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:4ba:9bd4:148:77e4])
        by mx.google.com with ESMTPSA id ch11sm6494405pdb.62.2014.08.26.15.14.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Aug 2014 15:14:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqlhqbge3a.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255952>

Hi again,

Junio C Hamano wrote:

> It seems that I can hold the topic in 'pu' a bit longer and expect a
> reroll from this effort before merging it to 'next'?

Sorry for the delay.  The following changes on top of "master"
(refs.c: change ref_transaction_update() to do error checking and
return status, 2014-07-14) are available in the git repository at

  git://repo.or.cz/git/jrn.git tags/rs/ref-transaction-1

for you to fetch changes up to 432ad1f39fd773b37757dd8f10b3075dc3d0d0a2:

  refs.c: make delete_ref use a transaction (2014-08-26 14:22:53 -0700)

----------------------------------------------------------------
"Use ref transactions", early part

Ronnie explains:

	This patch series expands on the transaction API. It converts
	ref updates, inside refs.c as well as external, to use the
	transaction API for updates. This makes most ref updates
	atomic when there are failures locking or writing to a ref.

This series teaches the tag, replace, commit, cherry-pick,
fast-import, checkout -b, branch, receive-pack, and http-fetch
commands and all update_ref and delete_ref callers to use the ref
transaction API instead of lock_ref_sha1.

The main user-visible change should be some cosmetic changes to error
messages.  The series also combines multiple ref updates into a single
transaction in 'git http-fetch -w' and when writing tags in
fast-import but otherwise doesn't change the granularity of
transactions.

Reviewed at https://code-review.googlesource.com/#/q/topic:ref-transaction-1

----------------------------------------------------------------
Ronnie Sahlberg (20):
      refs.c: change ref_transaction_create to do error checking and return status
      refs.c: update ref_transaction_delete to check for error and return status
      refs.c: make ref_transaction_begin take an err argument
      refs.c: add transaction.status and track OPEN/CLOSED
      tag.c: use ref transactions when doing updates
      replace.c: use the ref transaction functions for updates
      commit.c: use ref transactions for updates
      sequencer.c: use ref transactions for all ref updates
      fast-import.c: change update_branch to use ref transactions
      branch.c: use ref transaction for all ref updates
      refs.c: change update_ref to use a transaction
      receive-pack.c: use a reference transaction for updating the refs
      fast-import.c: use a ref transaction when dumping tags
      walker.c: use ref transaction for ref updates
      refs.c: make lock_ref_sha1 static
      refs.c: remove the update_ref_lock function
      refs.c: remove the update_ref_write function
      refs.c: remove lock_ref_sha1
      refs.c: make prune_ref use a transaction to delete the ref
      refs.c: make delete_ref use a transaction

 branch.c               |  31 ++++---
 builtin/commit.c       |  25 +++--
 builtin/receive-pack.c |  25 +++--
 builtin/replace.c      |  14 +--
 builtin/tag.c          |  16 ++--
 builtin/update-ref.c   |  14 ++-
 fast-import.c          |  54 +++++++----
 refs.c                 | 244 ++++++++++++++++++++++++++++---------------------
 refs.h                 |  77 ++++++++++++----
 sequencer.c            |  26 ++++--
 walker.c               |  70 ++++++++------
 11 files changed, 367 insertions(+), 229 deletions(-)

[...]
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -580,18 +580,18 @@ static char *update(struct command *cmd, struct shallow_info *si)
[...]
>>  		if (!transaction ||
>>  		    ref_transaction_update(transaction, namespaced_name,
>>  					   new_sha1, old_sha1, 0, 1, &err) ||
>>  		    ref_transaction_commit(transaction, "push", &err)) {
>> -			char *str = strbuf_detach(&err, NULL);
>>  			ref_transaction_free(transaction);
>>  
>> -			rp_error("%s", str);
>> -			return str;
>> +			rp_error("%s", err.buf);
>> +			strbuf_release(&err);
>> +			return "failed to update ref";
>>  		}
>
> I am guessing that the purpose of this change is to make sure that
> cmd->error_string is taken from a fixed set of strings, not an
> arbitrary collection of errors from the transaction subsystem, but
> what is the significance of doing so?  Do the other side i18n while
> running print_ref_status() or something?

It's about keeping the message in parentheses on the "! rejected
master -> master" line short and simple, since the more detailed
diagnosis is redundant next to the full message that is sent over
sideband earlier and gets a line to itself.

Side effects:

 * a less invasive patch --- no more need to change the calling
   convention to return a dynamically allocated string, with
   assertions throughout the file that check for leaks

 * using the same "all lowercase and brief" convention makes the
   message less jarring next to other statuses for "! rejected" lines,
   like "non-fast-forward"

 * no more O(n) stall from traversing the linked list to free messages
   when receive-pack is about to exit

[...]
>> diff --git a/refs.h b/refs.h
>> index aad846c..69ef28c 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -180,8 +180,7 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
>>   */
>>  #define REF_NODEREF	0x01
>>  /*
>> - * Locks any ref (for 'HEAD' type refs) and sets errno to something
>> - * meaningful on failure.
>> + * This function sets errno to something meaningful on failure.
>>   */
>>  extern struct ref_lock *lock_any_ref_for_update(const char *refname,
>>  						const unsigned char *old_sha1,
>
> To contrast this function with lock_ref_sha1() that only allowed
> refs under refs/ hierarchy, the comment may have made sense, but now
> that other function is gone, losing the comment makes sense.

Ahhh.  Thanks for explaining.

Jonathan
