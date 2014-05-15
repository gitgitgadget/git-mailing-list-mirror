From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v6 09/42] refs.c: change ref_transaction_create to do
 error checking and return status
Date: Thu, 15 May 2014 09:56:31 -0700
Message-ID: <20140515165631.GC27279@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
 <1398976662-6962-10-git-send-email-sahlberg@google.com>
 <20140515000409.GF9218@google.com>
 <CAL=YDWn5+_jA55KGx74We=41ngxSDA6yKJbuZ=3zy8gZTYPYnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 18:56:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkyxT-0006Gi-1M
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 18:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbaEOQ4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 12:56:35 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:64578 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbaEOQ4e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 12:56:34 -0400
Received: by mail-pa0-f54.google.com with SMTP id bj1so1320341pad.27
        for <git@vger.kernel.org>; Thu, 15 May 2014 09:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=z/xfewaohNF+roJQhG7Pg7OhzrLu27t7H7PF4gKMooo=;
        b=ksEVGMofIElVX2EV9tNFr70DkmdHyhMnGDCzcfmm8AKBUCrQFDfMrXxOSa7DDnpaVT
         afWeLV2yf6hmeE/8tLuCZBSJM+RYBbDoEDZ6JmF7GtbMuRVSCVLz9G2kRI7a3X17+TXD
         HtFEJO8VzygkcAnt1VrweYN5zOghiJJD/q5jYrVl0Y+dS16xUt3fOkTWqxOiWut7HnTB
         mXPtAFVX2Im8fOZn3ArWY9YzdkbribqfhiWJx6pRDYHRDUqNkoYki7Y0geqcWqH8IN4D
         0D+MD6MgcudN0Hk76ffBNrq2O/ukZIa1hqpkjGKMXE0ufTOWDnoDiSMba1yf9xfaZYYH
         fVZg==
X-Received: by 10.66.226.172 with SMTP id rt12mr14033173pac.101.1400172994309;
        Thu, 15 May 2014 09:56:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id sv10sm9988827pbc.74.2014.05.15.09.56.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 09:56:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL=YDWn5+_jA55KGx74We=41ngxSDA6yKJbuZ=3zy8gZTYPYnQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249117>

Ronnie Sahlberg wrote:
> On Wed, May 14, 2014 at 5:04 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> If it were ever triggered, the message
>>
>>         error: some bad thing
>>         fatal: failed transaction create for refs/heads/master
>>
>> looks overly verbose and unclear.  Something like
>>
>>         fatal: cannot create ref refs/heads/master: some bad thing
>
> I changed it to :
>    die("cannot create ref '%s'", refname);
>
> But it would still mean you would have
>          error: some bad thing
>          fatal: cannot create 'refs/heads/master'
>
> To make it better we have to wait until the end of the second patch
> series, ref-transactions-next
> where we will have an err argument to _update/_create/_delete too and
> thus we can do this from update-ref.c :
>
>    if (transaction_create_sha1(transaction, refname, new_sha1,
>        update_flags, msg, &err))
>    die("%s", err.buf);

Thanks.  Sounds good.
