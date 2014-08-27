From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/20] rs/ref-transaction-1 (Re: Transaction patch series
 overview)
Date: Tue, 26 Aug 2014 17:28:04 -0700
Message-ID: <20140827002804.GA20185@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140826000354.GW20185@google.com>
 <xmqqlhqbge3a.fsf@gitster.dls.corp.google.com>
 <20140826221448.GY20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 02:28:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMR62-0004k1-NI
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 02:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769AbaH0A2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 20:28:10 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:63293 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755318AbaH0A2J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 20:28:09 -0400
Received: by mail-pd0-f174.google.com with SMTP id fp1so23552457pdb.19
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 17:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wdUbRPdlGQZzp3m+WxK8RZ9IoQ3TxVKCN//8l7Sl2uE=;
        b=dXzJnV7XBj7H9w7zp+spTe5LyhWffh2+1mE7wgH/6v+mepmnOtHEXhxNEOIidmfjcf
         7qXJr0QIuUOjulXzmovO+up9aHXHk7elOBouPx4xLcRdb1S5njnn6zhIEdoQg7rMOGby
         wzTnLrx6Il9a/qhULlv7/WkK5lsDDKlG2ZfBuSu+UF3RsqEzRqpVYmSYQS7cblxWKTBi
         OlRjeZrN8gnO9KfGnNbfxaGRavIKHYZ4nKG43pJOccs5PNpsInIeS4aP/onNLZgOXws+
         Ct+6h/7jQ+J3jiN9uom1Sz1wK42nZpep1M/mTgNcK/kJPeAj0ZMgGGdnBA4K7gHxhAvD
         GVxQ==
X-Received: by 10.68.93.1 with SMTP id cq1mr41233540pbb.42.1409099288896;
        Tue, 26 Aug 2014 17:28:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:4ba:9bd4:148:77e4])
        by mx.google.com with ESMTPSA id ko5sm6866045pdb.51.2014.08.26.17.28.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Aug 2014 17:28:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140826221448.GY20185@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255955>

Jonathan Nieder wrote:

> This series teaches the tag, replace, commit, cherry-pick,
> fast-import, checkout -b, branch, receive-pack, and http-fetch
> commands and all update_ref and delete_ref callers to use the ref
> transaction API instead of lock_ref_sha1.
>
> The main user-visible change should be some cosmetic changes to error
> messages.  The series also combines multiple ref updates into a single
> transaction in 'git http-fetch -w' and when writing tags in
> fast-import but otherwise doesn't change the granularity of
> transactions.
>
> Reviewed at https://code-review.googlesource.com/#/q/topic:ref-transaction-1
>
> ----------------------------------------------------------------
> Ronnie Sahlberg (20):
>       refs.c: change ref_transaction_create to do error checking and return status
>       refs.c: update ref_transaction_delete to check for error and return status
>       refs.c: make ref_transaction_begin take an err argument
>       refs.c: add transaction.status and track OPEN/CLOSED
>       tag.c: use ref transactions when doing updates
>       replace.c: use the ref transaction functions for updates
>       commit.c: use ref transactions for updates
>       sequencer.c: use ref transactions for all ref updates
>       fast-import.c: change update_branch to use ref transactions
>       branch.c: use ref transaction for all ref updates
>       refs.c: change update_ref to use a transaction
>       receive-pack.c: use a reference transaction for updating the refs
>       fast-import.c: use a ref transaction when dumping tags
>       walker.c: use ref transaction for ref updates
>       refs.c: make lock_ref_sha1 static
>       refs.c: remove the update_ref_lock function
>       refs.c: remove the update_ref_write function
>       refs.c: remove lock_ref_sha1
>       refs.c: make prune_ref use a transaction to delete the ref
>       refs.c: make delete_ref use a transaction

And here are the patches.
