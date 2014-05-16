From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 21/44] refs.c: ref_transaction_commit should not free
 the transaction
Date: Fri, 16 May 2014 08:15:47 -0700
Message-ID: <CAL=YDW=xfdBvS7RjzZC0QbpN8zhCyXi760DyNXzgqrB9ydJr5w@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-22-git-send-email-sahlberg@google.com>
	<20140516002029.GB11011@google.com>
	<CAL=YDWkdjjMmVNcXHYr2CGsR4-eU0aHHR5Ek6JipL-Xhi=p7-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 17:16:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJrY-000118-Dt
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 17:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbaEPPPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 11:15:51 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:38682 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932452AbaEPPPt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 11:15:49 -0400
Received: by mail-vc0-f179.google.com with SMTP id im17so6430329vcb.10
        for <git@vger.kernel.org>; Fri, 16 May 2014 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=x1bI5ws9Of2OQATUUsNmQl5/mBUJ19KGEn4dAKV7hrc=;
        b=pYiZYpBbKfUnY4EwSySyQASplpINBek8ymVskdUR5F4303BQAhyIoijK0Zj7LcGSeS
         Sb1RHbk3BZa87ubRnHq2pL+N3IpA8zZMRcLaboSYduGejAngog9jB3h4mD/h39/S/yH/
         Srdh5d4yV3yQ5yuABnxYiPm0HcoaJBlROkLOzUINN2C3NscAJx7EyTvOJ6P+u9S+PgEk
         LpfIbCVHxLj+OuMpN2kgdJxYvfx0UXDF3wqI6pW6G6cvq4pQsnYGp66bFq0hNdC2wNdy
         d3FpFZZK9tgWElSlvq8PUugwyNOLJvsovgoSL4io1KUgW8aYUuIzLgwzbiGOIOIrIBgT
         BHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=x1bI5ws9Of2OQATUUsNmQl5/mBUJ19KGEn4dAKV7hrc=;
        b=aI8MBQwg5ML9TnudxaBKC75V/walKK2DcwMkdZfyaYHN1bcIKfc5nU9JcdBA5ko6AR
         GyJyghUtgkBWiILqelYYijU1d5IZTjzAZMR67rWetQxLAfbkzO9/XYvkOMTpHFrYnQxM
         VT+lCFgeD0NU+mk6A3ANx0pnyy7kz4rdMvS5jPN3f0ziJVsYja5fpWcQWHNGtnetNnTH
         V+15ROeygg833VYVEeZbS6iU/9pdaWbz5lCpxvcjK5m1Hc3Cv3lVQEJnFQQc6Bfc+mpp
         ahJ8zgM0JzX4yDNp2eKPOG4BfiLRBPkKrdh4rUfaK8KE0MzXmvp3pVPMmyqQHRzKLTEa
         6+VQ==
X-Gm-Message-State: ALoCoQmqfK5tBO9bEeNvQvUfHy871esmCn2mWYOrYOfECq4wdTaeelXKGEzDi7MmUEbmuvSlqzP6
X-Received: by 10.220.47.201 with SMTP id o9mr659197vcf.65.1400253347990; Fri,
 16 May 2014 08:15:47 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Fri, 16 May 2014 08:15:47 -0700 (PDT)
In-Reply-To: <CAL=YDWkdjjMmVNcXHYr2CGsR4-eU0aHHR5Ek6JipL-Xhi=p7-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249344>

On Fri, May 16, 2014 at 8:02 AM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> On Thu, May 15, 2014 at 5:20 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Ronnie Sahlberg wrote:
>>
>>> Change ref_transaction_commit so that it does not free the transaction.
>>> Instead require that a caller will end a transaction by either calling
>>> ref_transaction_rollback or ref_transaction_free.
>>
>> Can I always use ref_transaction_rollback instead of ref_transaction_free?
>> It would be convenient if my cleanup code could always call _rollback
>> instead of having to do something different for success and errors.
>
> Currently, yes.
>
> But it might make sense to change these so rollback only clears the
> updates that are in flight from the transaction and
> free only frees the transaction itself iff there are no updates in flight.
>
> I.e. the success and error would then differ like this :
> ...
>    if (transaction_commit()) {
>        transaction_rollback()
>        transaction_free()
>        return error("some error")
>    }
>    transaction_free()
>

But we do not really need rollback right now. If / when we decide to
need re-startable/re-usable transactions we can add it back when
needed.

Let me update the patch series and remove transaction_rollback and
replace all calls to it with calls to transaction_free instead.


>
>
>>
>> Another way to ask the question: what is it valid to do with a
>> transaction after commiting?
>
> Right now the only valid thing to do is either rollback or free. But
> we could allow other things too :
>
>
> re-usable transactions.
> ---------------------------------
> I don't know if this is a good reason or not, but one reason we might
> want to keep
> two different names could be if we want to start allowing to re-use
> transactions.
> For example for cases/backends where transaction_begin() might be very
> expensive.
>
> For that case I would imagine we could allow to do things such as
>
> t = transaction_begin()
> ...
> /* first transaction */
> transaction_update(...)
> transaction_commit(...)
>      if transaction failed   transaction_rollback(...)
>
> /* second transaction,  first transaction cleared all updates in
> flight either through commit or through rollback */
> transaction_update()
> transaction_commit()
>      if transaction failed   transaction_rollback(...)
> ...
> transaction_free()
>
>
> (In order to do something like this we would still need to do some
> changes so that rollback will only free the updates that were in
> flight but not free the transaction itself.)
>
>
>>
>> Thanks,
>> Jonathan
