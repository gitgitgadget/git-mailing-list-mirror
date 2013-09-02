From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH v2 6/8] refs: add update_refs for multiple simultaneous
 updates
Date: Mon, 02 Sep 2013 13:20:37 -0400
Message-ID: <5224C8E5.1080908@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <cover.1377885441.git.brad.king@kitware.com> <edaddbd4e303866f789f1a4f755a9da77590aeef.1377885441.git.brad.king@kitware.com> <52223398.2080109@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Martin Fick <mfick@codeaurora.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 02 19:22:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGXpf-0000qX-FE
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 19:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758723Ab3IBRW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 13:22:27 -0400
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:37999 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756322Ab3IBRW1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Sep 2013 13:22:27 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]) (using TLSv1) by na3sys009aob101.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUiTJUjpJs7ITgFNNwxsRXapjRGjy1Ihr@postini.com; Mon, 02 Sep 2013 10:22:26 PDT
Received: by mail-oa0-f51.google.com with SMTP id h1so5448982oag.24
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 10:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=aJqbWuqPSQxqq7ZVF70CpUl9ZFxKZ02SXTV/4id4knQ=;
        b=KxKpZfR/BHLDJxWZwxlDny+lJ5ZPVWBnyCDzlnwBxm0TyHx0s3aEXVcTlRUNhCC29T
         BJFuFxP608uU/YiF7tZqPEitTuB7OTI0kbEPkWOV6PFS1qbNcg8ieNi1JBCPwEDQ3Mgu
         yN9YBSaz17BQ9K0bszeOQElA83lm4Bz3Nh1qSffG+UUNo4Kb13YBWveeuoVW2pt1rKK5
         JG9Sjdpgo/GJJHdbIK3xWEtK9fa/ouL8N22f84gS7TRJPcAbwqvGQQsV707DvG+To6i7
         wk3jFijw5r0EbnAJafSWiHbrBig60FhGiZQO25oU6y/HR4HMEvxcJNylF4Bxvs3YaOhf
         fjVA==
X-Gm-Message-State: ALoCoQkY+DzKzxmtPzIVK4JcAwnMmFz9q/7PFfvPUHXctod+OkqR90bAjcknXAiyOt1fAb0HUEB3tcrG/eTzU3+cbqZacChy7Z4Jn+MXe0DZB7TdT0toy7v+cfHoBOyuHI0lHlv2LSQYqNEF/U4+bZxPWqwybl0FPA==
X-Received: by 10.60.102.66 with SMTP id fm2mr18178420oeb.21.1378142546197;
        Mon, 02 Sep 2013 10:22:26 -0700 (PDT)
X-Received: by 10.60.102.66 with SMTP id fm2mr18178412oeb.21.1378142546116;
        Mon, 02 Sep 2013 10:22:26 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id a18sm13911916obf.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Sep 2013 10:22:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <52223398.2080109@alum.mit.edu>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233640>

On 08/31/2013 02:19 PM, Michael Haggerty wrote:
> s/themeselves/themselves/

Fixed.

>> +	struct ref_update *u1 = (struct ref_update *)(r1);
>> +	struct ref_update *u2 = (struct ref_update *)(r2);
> 
> If you declare u1 and u2 to be "const struct ref_update *" (i.e., add
> "const"), then you have const correctness and don't need the explicit
> casts.  (And the parentheses around r1 and r2 are superfluous in any case.)

Fixed.

>> +	ret = strcmp(u1->ref_name, u2->ref_name);
> 
> Is there a need to compare more than ref_name?  If two entries are found
> with the same name, then ref_update_reject_duplicates() will error out

Junio mentioned possibility of auto-combining identical entries which would
need full ordering.  I think that can be added later so for now we can sort
only by ref name.  Thanks.

>> +		if (!strcmp(updates[i - 1].ref_name, updates[i].ref_name))
>> +			break;
> 
> The error handling code could be right here instead of the "break"
> statement, removing the need for the "if" conditional.

Fixed.

>> +	/* Allocate work space: */
>> +	updates = xmalloc(sizeof(struct ref_update) * n);
> 
> It seems preferred here to write
> 
> 	updates = xmalloc(sizeof(*updates) * n);
> 
> as this will continue to work if the type of updates is ever changed.

Yes, thanks.

> Similarly for the next lines.
> 
>> +	types = xmalloc(sizeof(int) * n);
>> +	locks = xmalloc(sizeof(struct ref_lock *) * n);
>> +	delnames = xmalloc(sizeof(const char *) * n);
> 
> An alternative to managing separate arrays to hold types and locks would
> be to include the scratch space in struct ref_update and document it
> "for internal use only; need not be initialized by caller".  On the one
> hand it's ugly to cruft up the "interface" with internal implementation
> details; on the other hand there is precedent for this sort of thing
> (e.g., ref_lock::force_write or lock_file::on_list) and it would
> simplify the code.

I think the "goto cleanup" reorganization simplifies the code enough
to not need this.  After changing "updates" to an array of pointers
it needs to be separate so we can sort.  Also "delnames" needs to be
a separate array to pass to repack_without_refs.

>> +	/* Copy, sort, and reject duplicate refs: */
>> +	memcpy(updates, updates_orig, sizeof(struct ref_update) * n);
>> +	qsort(updates, n, sizeof(struct ref_update), ref_update_compare);
> 
> You could save some space and memory shuffling (during memcpy() and
> qsort()) if you would declare "updates" to be an array of pointers to
> "struct ref_update" rather than an array of structs.  Sorting could then
> be done by moving pointers around instead of moving the structs.  This
> would also make it easier for update_refs() to pass information about
> the references back to its caller, should that ever be needed.

Good idea.  Changed in next revision.

>> +			ret |= update_ref_write(action,
>> +						updates[i].ref_name,
>> +						updates[i].new_sha1,
>> +						locks[i], onerr);
>> +			locks[i] = 0; /* freed by update_ref_write */
>> +		}
>> +
> 
> Hmmm, if one of the calls to update_ref_write() fails, would it be safer
> to abort the rest of the work (especially the reference deletions)?

Yes.  Since we already have the lock at this point something must be
going pretty wrong if this fails so it is best to abort altogether.

>> +	free(updates);
>> +	free(types);
>> +	free(locks);
>> +	free(delnames);
>> +	return ret;
>> +}
> 
> There's a lot of duplicated cleanup code in the function.  If you put a
> label before the final for loop, and if you initialize the locks array
> to zeros (e.g., by using xcalloc()), then the three exits could all
> share the same code "ret = 1; goto cleanup;".

Done, thanks.

>> +struct ref_update {
> 
> Please document this structure, especially the relationship between
> have_old and old_sha1.

Done.  I also moved it to the top of the header just under ref_lock
so it can be used by other APIs later.

Thanks,
-Brad
