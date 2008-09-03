From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v2] for-each-ref: `:short` format for `refname`
Date: Wed, 3 Sep 2008 10:33:48 +0200
Message-ID: <36ca99e90809030133r43fc5a3agad1aa38339a758a3@mail.gmail.com>
References: <20080902143912.GB28704@spearce.org>
	 <1220392637-24978-1-git-send-email-bert.wesarg@googlemail.com>
	 <7v63pei1pz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, szeder@ira.uka.de,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 10:35:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KanpI-0000EE-Fk
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 10:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbYICIdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 04:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbYICIdu
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 04:33:50 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:32485 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbYICIdt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 04:33:49 -0400
Received: by wx-out-0506.google.com with SMTP id h29so745369wxd.4
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 01:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=rriffcRRbOPZ/F46empAWmMt+4n9dbukSevlmtKs18A=;
        b=qcTKQ92Z01Iw4WOK8yn8dOOSpgFfxyE7GFnIFvy86jhYxpVJxup9A8qtz15+krDqF+
         Z24kdEzM4Iji2+dlEoEOLCeceA4vV6VtpZhjYi5fvpwBYDa/zkofryaYHXzTzTTRZ+rp
         erhAqqnBExwi48fmKbmnslTbXr8q0lCdCUAdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FzQnvRbqAKBAFivMnHTfEOETksUxm0nvIcZTVUlWjhs8y+RCOZXwLpuxMmuvJ8KxCs
         suV5PpKd7/nnlx0c3dyWbzCz0Aej6AERIYtW3Y7exAQufqJXiZ1I8ZWPthYI6e+XE438
         WQTNLgkTkr9/BJU8LbF59PbbGk50RUQlsSk/M=
Received: by 10.70.113.12 with SMTP id l12mr10808523wxc.42.1220430828535;
        Wed, 03 Sep 2008 01:33:48 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Wed, 3 Sep 2008 01:33:48 -0700 (PDT)
In-Reply-To: <7v63pei1pz.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94762>

On Wed, Sep 3, 2008 at 01:10, Junio C Hamano <gitster@pobox.com> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> Tries to shorten the refname to a non-ambiguous name.
>> I.e. the full and the short refname points to the same object.
>
> The definition of "ambiguity" here is wrong (see below).
>
>> +              * by checking all rules in forward direction
>> +              */
>
> I think this part of the code is wrong, in that it talks about what object
> the ref points at.  That is not what ref ambiguity is about.
>
> Given a tag that points at a version 1.0.0 commit, this sequence will
> create:
>
>        $ git tag foo v1.0.0^0
>        $ git branch foo v1.0.0^0
>
> ambiguous branch and tag whose names are both 'foo', even though they
> point at the same thing.  The right API to use would be resolve_ref(), I
> think.
I use resolve_ref():

int read_ref(const char *ref, unsigned char *sha1)
{
	if (resolve_ref(ref, sha1, 1, NULL))
		return 0;
	return -1;
}

Ok, I think I get your point: it doesn't matter if the full and short
point to different objects, it's enough for ambiguity that the short
name resolves to more than one ref.

New patch in reply.

>
> Other than that, it is well done.
>
> Although I was initially a bit surprised by the size of the patch to
> implement something so (conceptually) simple, the code was easy and
> straightforward to follow.
>
> Thanks.
Your welcome.

Bert
>
