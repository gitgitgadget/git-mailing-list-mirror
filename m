From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Implement rebase -q to fix pull --rebase -q
Date: Wed, 3 Dec 2008 09:07:52 +0100
Message-ID: <4ac8254d0812030007w3217f6eei3d364ce2272930c3@mail.gmail.com>
References: <1228277212-5917-1-git-send-email-tuncer.ayaz@gmail.com>
	 <7vej0pheww.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 09:09:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7mnH-0008Th-T4
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 09:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975AbYLCIHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 03:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbYLCIHz
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 03:07:55 -0500
Received: from rn-out-0910.google.com ([64.233.170.186]:48367 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbYLCIHy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 03:07:54 -0500
Received: by rn-out-0910.google.com with SMTP id k40so2825871rnd.17
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 00:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=12XDyeC1QIMpZLNyWOtWdkvjSssViKN+BkFezn+HBm8=;
        b=lhWUsCddhCbAw48cvd1NOVW3pWIt61Gql2BGe1JGpY3B6rQZIhFpiSzDgQaPNF3l74
         GTaKXCsRXiK+ZGuuAyjarqinpEsL87bktoqkpAZlMTXZu1w3Li6ojGbOEab1Op9f56Im
         VDB2+gCOLZzfSHy5vzhZ8LedIMDOPpsq5LLIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Zs2WQ4AFwlvKZpsZJsb+ySxHdiItffNaoA+hziZrBn9QQGs6g9aw3Ng6VUDk9k8CwN
         ZpK4fsEQrBVmLKkz900AYiJjFUGly9Es8B31/99vtw657lFq80oZ+xbU/prVlKJ5fGEV
         CRZysXsQ3Rw1TaF7ti/KoD1PSsrzuNJHPTE34=
Received: by 10.64.143.4 with SMTP id q4mr13144530qbd.67.1228291672992;
        Wed, 03 Dec 2008 00:07:52 -0800 (PST)
Received: by 10.65.242.16 with HTTP; Wed, 3 Dec 2008 00:07:52 -0800 (PST)
In-Reply-To: <7vej0pheww.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102223>

On Wed, Dec 3, 2008 at 8:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Tuncer Ayaz <tuncer.ayaz@gmail.com> writes:
>
>> This is needed on top of the fetch/pull -q/-v changes
>> to make
>> $ git pull --rebase -q
>> as quiet as expected.
>
> I am not sure if this is worth it, in the sense that it is not really
> quiet enough (iow, it is not what I expect even though you claim "as

Junio, sorry for using 'expected'.
I thought about the wording while writing and had a feeling that 'expected'
may be too strong as it's my opinion only. I should have listened to myself :).

> expected" here), and in another sense that making it really quiet may not
> be what we want anyway.

I mainly use -q in automation where I only want output if something
goes wrong. Just like good old cp or mv do.
Do you think this is the wrong way to go?

> How are you dealing with messages from the actual replaying of each local
> commit on top of what is fetched?  In order to be able to tell where you
> are when one of them fail in conflicts, you cannot stay silent while doing
> so.

Fair point.

Log messages that are of importance to a failure should ideally be sent to
stderr but I think caching log messages for the failure case would
over-complicate
much of the code and is not worth it. Also you may not always know which part
of stdout messages are useful for the failure case and not getting the
same messages
on a rerun for many commands makes this hard to trace back, yeah.

As we've quietened pull/fetch/clone in a major already I am OK with leaving this
change out.
I'm definitely not advocating adding/changing anything when it's not clear we
want the changed behavior. It's easier to keep out than to remove it
later on :).
