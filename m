From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Can I remove stg sync --undo ?
Date: Mon, 7 Jul 2008 21:47:13 +0100
Message-ID: <b0943d9e0807071347n17e2e09ai761b849d2d03bc9c@mail.gmail.com>
References: <20080702072524.GA26805@diana.vm.bytemark.co.uk>
	 <b0943d9e0807031502x5f7c4babtd65511d7966c69f6@mail.gmail.com>
	 <20080704020918.GA30669@diana.vm.bytemark.co.uk>
	 <b0943d9e0807041505oc15660bpcd62a62100e517b9@mail.gmail.com>
	 <20080705083348.GA21097@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 22:48:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFxd9-00089X-Et
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 22:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168AbYGGUrQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jul 2008 16:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756159AbYGGUrQ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 16:47:16 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:35664 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756150AbYGGUrP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jul 2008 16:47:15 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1046596ywe.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 13:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=atFEyiX4uFI1y5iVaomP9vnUk93RRspESVf1Xc3gzTw=;
        b=sZ6i97JMdWV9OaV5zmSBGRy7rQb2Ve1PCrsuVf6Z7vzEJWnYDKRQ1LE6/xCDpjGj17
         8gglSoh+BM7YjjZKCITetIixK+XvvYHQEA/DCH0JJY8Ui1Z/1kJL3BH2p8Bq+MdFwfii
         zjtrDUcaqt4Te3zz2Dq8GX/jzHrjsOlWa3s48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=LMvLAGRLEXQUh5lCcg/ztmO3BBc9A8ggDn43Q6R6pLG7ZBpx5Rwnwh8vZHidGsXe//
         CgW4tkW8aSd6LP5YFyOg7wv5RuJd5GyvVRm0hdb4QM1/UfiXnjyngrdjZOC27j39MngY
         0tJM0a6Y9ZPu3mrFbNHScH+IyCVByKMuD0wAQ=
Received: by 10.115.32.8 with SMTP id k8mr7065977waj.89.1215463633403;
        Mon, 07 Jul 2008 13:47:13 -0700 (PDT)
Received: by 10.114.124.9 with HTTP; Mon, 7 Jul 2008 13:47:13 -0700 (PDT)
In-Reply-To: <20080705083348.GA21097@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87651>

2008/7/5 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-07-04 23:05:11 +0100, Catalin Marinas wrote:
>
>> 2008/7/4 Karl Hasselstr=F6m <kha@treskal.com>:
>>
>> > On 2008-07-03 23:02:28 +0100, Catalin Marinas wrote:
>> >
>> > > The sync performs three operations - push, merge and refresh (if
>> > > the refresh is automatic after merge, it doesn't update the
>> > > backup information since it was done by merge).
>> > >
>> > > If merge fails, the refresh is manual after solving the
>> > > conflicts. I suspect this will be recorded as a separate step
>> > > for undo
>> >
>> > Yeah, the new undo stuff will currently handle sync just like e.g.
>> > push and pop: write one log entry when the command's all done,
>> > plus one extra just before the conflicting push if there is one.
>> > So you can always undo the entire command; and in case of
>> > conflicts, you also have the option of undoing just the
>> > conflicting push. Is this enough for sync?
>>
>> There are two operations that can conflict for sync - pushing a
>> patch and the actual sync'ing, i.e. a three-way merge with the patch
>> to be synchronised with (kind of fold).
>
> My guess is that conflicts of the first type would work out of the bo=
x
> (i.e. they'd get an extra log entry) while conflicts of the second
> type would not.

I don't really care as long as I can get back to the patch state
before running the sync command if anything goes wrong. So, one undo
level would be enough.

> We need a sync undo test.

Yes but not sure what how undo would behave in this situation yet.

>> > > (BTW, is resolved take into account for undo?).
>> >
>> > Hmmm, what do you mean by "resolved"?
>>
>> The current resolved command - the clearing of the conflicting
>> entries in the index.
>
> With just "stg undo" (or reset or redo), you get the usual
> new-infrastructure check about dirty index and working tree (the whol=
e
> index must be clean, and the parts of the worktree we need to touch
> must be clean). Which prevents you from undoing a conflicting push,
> for example.
>
> With the --hard flag, any uncleanliness in index or worktree simply
> gets zapped (just like with git reset --hard). I'm not 100% happy wit=
h
> this -- what I'd really like is to zap only the files that we need to
> touch. But I haven't figured out a good way to do that.

OK, not much to comment here, it's your implementation :-).

--=20
Catalin
