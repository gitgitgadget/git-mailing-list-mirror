From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 1/3] for-each-ref: utilize core.warnambiguousrefs for strict refname:short format
Date: Mon, 22 Sep 2008 20:00:50 +0200
Message-ID: <36ca99e90809221100q4db71514re448f5fa36a19ffc@mail.gmail.com>
References: <1222074591-26548-1-git-send-email-bert.wesarg@googlemail.com>
	 <7vk5d4xi1m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, szeder@ira.uka.de,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 20:02:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khpjb-0004Tz-Cs
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 20:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbYIVSAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 14:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbYIVSAx
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 14:00:53 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:55845 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbYIVSAw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 14:00:52 -0400
Received: by gxk9 with SMTP id 9so3375355gxk.13
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 11:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8MqGIE7pIpUNrYB8Ox7q+kZgVaJMmDKumwZUu/c+j58=;
        b=v+5gowqWitco+wCkU0MJLx3Tv+qK8JbDE1aY4pp0iDY8OaEUIBUzHnxsnnHkBXcQNZ
         bmOUB1kUhAXHj/gYk8Nr2pjXgGqP2R3OP3wq8jVUQpUM+9ELzuY+O2vfnRKam5YxP4OW
         En5KesQ05SWm7J2V7lvNyTuLeBOXdzrQ26018=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FNd17xzhFzBMVs5dVFyt99jNRqJTUybyx9gDxXx4/M5vEAwY3VTQNhWSc/MEZmyQw1
         mcdstpHu7ZgCdu1lkRnnvAgf6xSPNOHFmlhsumFobQffZLL5PzvPieVfo1fkenLpYUZu
         8MYw9rakyJDiWPuYcBL2OVNjg5QsPa0vpJfAA=
Received: by 10.151.42.18 with SMTP id u18mr7749485ybj.57.1222106450935;
        Mon, 22 Sep 2008 11:00:50 -0700 (PDT)
Received: by 10.150.204.17 with HTTP; Mon, 22 Sep 2008 11:00:50 -0700 (PDT)
In-Reply-To: <7vk5d4xi1m.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96503>

On Mon, Sep 22, 2008 at 18:27, Junio C Hamano <gitster@pobox.com> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
>> index 9b44092..e7b7712 100644
>> --- a/builtin-for-each-ref.c
>> +++ b/builtin-for-each-ref.c
>> @@ -571,7 +571,7 @@ static void gen_scanf_fmt(char *scanf_fmt, const char *rule)
>>  /*
>>   * Shorten the refname to an non-ambiguous form
>>   */
>> -static char *get_short_ref(struct refinfo *ref)
>> +static void get_short_ref(struct refinfo *ref, int strict, char **short_ref)
>>  {
>>       int i;
>>       static char **scanf_fmts;
>
> As far as I can tell this changing of function signature does not help its
> existing caller nor the function's implementation.
>
> Why?  And especially why do this in a patch that does something else?
Good point.  I think it had something to do that I first want a
reverse of dwim_ref().  And this has this 'char **' argument.  Than I
changed it back to the old signature which makes this line:

-                                       refname = get_short_ref(ref);
+                                       refname = get_short_ref(ref,
warn_ambiguous_refs);

unbreakable or screams for an out factoring of all inside the 'if
(!prefixcmp(name, "refname")) {'

I would prefer the out factory.

Bert
