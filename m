From: Brandon Casey <drafnel@gmail.com>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file descriptor
Date: Tue, 15 Jan 2008 20:11:55 -0600 (CST)
Message-ID: <Pine.LNX.4.44.0801152006260.944-100000@demand>
References: <7vmyr6bluy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:26:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JExyi-0005HZ-5j
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 03:26:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbYAPCZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 21:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbYAPCZk
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 21:25:40 -0500
Received: from hs-out-0708.google.com ([64.233.178.245]:26013 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751302AbYAPCZj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 21:25:39 -0500
Received: by hs-out-2122.google.com with SMTP id 54so64809hsz.5
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 18:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:mime-version:content-type:from;
        bh=3+m6gqxQBS2+5VCc9zUSgng1ovSRCcgvgt62wa5h7Pw=;
        b=uvwi61zElFXEMYkprqxR3mr2GjUoUVlus5Dhu2HbzrDajUyYB6pGNKecQR1uHzin7XOR0eW+DSdJ+2iELOThkoa1b/Zzl7ivDLvkUSLyfXowYIJlojbXZkYS4rHNwf155/Bh4V9HzzyIPxEyiMhgiOmvmZtn4WcjMCAca41iLOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:x-x-sender:to:cc:subject:in-reply-to:message-id:mime-version:content-type:from;
        b=LSK0ucg6i7HmnYLKVVK77TiOYiglUsJo3W20EipE5wqbPVtWVKMAfNaZl8jEJwOHduyI5UrfNsp440Z3m4EDB9CiozmSp8Akvz85CMuJeC6lamSH+1/hBmjZYMe2FQEHtgcsKlMik3wZUNUxojmUCIgwkNl1wI5THKTMHWpBA9k=
Received: by 10.143.8.10 with SMTP id l10mr109684wfi.181.1200450337943;
        Tue, 15 Jan 2008 18:25:37 -0800 (PST)
Received: from demand ( [216.107.110.92])
        by mx.google.com with ESMTPS id i35sm768349wxd.34.2008.01.15.18.25.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Jan 2008 18:25:37 -0800 (PST)
X-X-Sender: casey@demand
In-Reply-To: <7vmyr6bluy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70606>

On Tue, 15 Jan 2008, Junio C Hamano wrote:

>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> While I think the ones that are immediately followed by
>> commit_locked_index() can drop the close(fd) safely, I am not
>> sure about Kristian's changes to the other ones that we
>> currently close(fd) but do not commit nor rollback immediately.
>> These indices are now shown to the hook with open fd to it if
>> you choose not to close them.  Is that okay for Windows guys?  I
>> somehow had an impression that the other process may have
>> trouble accessing a file that is still open elsewhere for
>> writing.
>>
>> So I think the approach along the lines of your "hack" to close
>> and tell lockfile API not to double-close is more appropriate.
>> We would perhaps want "close_lock_file(struct lock_file *)" that
>> calls close(lk->fd) and does lk->fd = -1 without rename/unlink,
>> and replace these close() with that.
>>
>> I am sick today, feeling feverish, and not thinking straight,
>> so I may be talking total nonsense...

> I'll aplly and push out Kristian's one that apparently got
> Tested-by from Brandon for tonight.

I've got a followup patch coming that will remove the rest of
the redundant close()'s and I'll look into your suggestion for
close_lock_file() above.

Currently everything passes the test suite, I just need to do
some manual testing.

-brandon
