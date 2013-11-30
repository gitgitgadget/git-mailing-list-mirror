From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v4 12/24] read-cache: read index-v5
Date: Sat, 30 Nov 2013 21:10:03 +0100
Message-ID: <87ob51y7l0.fsf@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com> <1385553659-9928-13-git-send-email-t.gummerer@gmail.com> <CALWbr2ybgpdDJLRKA4zwPmRE4LQv4VWLJM6Jv0dO-GyHREGW7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	robin.rosenberg@dewire.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	ramsay@ramsay1.demon.co.uk
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 30 21:10:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vmqrh-0008Jb-6i
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 21:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379Ab3K3UKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Nov 2013 15:10:05 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61082 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab3K3UKE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 15:10:04 -0500
Received: by mail-lb0-f174.google.com with SMTP id c11so7745168lbj.33
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 12:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=nO5mnu6GJkoPj5dnopb6+WsIeZX/FQGVMlLdky7azEY=;
        b=sb8pXdtTf4/vFMR9pv4MYEdj8qPp35FMil3KN2zhCfLI6XSPD2X6yYccFE0QexG0c4
         aXMIZUSgV3F7uvwRKLfA44NNxTK+t2H+5voc1Nch1YQVIX1bA0eCODu/res1oSFE8Nly
         Jza1qwweUkTEy1zN59Zpb7XFejdA/hB1EhvwHGV24/gySdagXr6CMI2kBoFlPz49S1p4
         Q20+//Tae0/oK40cznrmAwyyZ+5dXwTwoc9+HBJJUuwYWyW4VkirVYroV33h9vzZDk1f
         08uDGYqnstD92TPlbwxrpXmIC6mR6f8IAI+bxehBtrS9RhRcyMbrUffjyltD37qdpukN
         UDRw==
X-Received: by 10.112.136.99 with SMTP id pz3mr7899054lbb.3.1385842201925;
        Sat, 30 Nov 2013 12:10:01 -0800 (PST)
Received: from goose.tgummerer.com (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id c15sm20023784lbq.11.2013.11.30.12.10.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Nov 2013 12:10:00 -0800 (PST)
In-Reply-To: <CALWbr2ybgpdDJLRKA4zwPmRE4LQv4VWLJM6Jv0dO-GyHREGW7g@mail.gmail.com>
User-Agent: Notmuch/0.17~rc1+8~g4a09c1a (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238570>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Wed, Nov 27, 2013 at 1:00 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> Make git read the index file version 5 without complaining.
>>
>> This version of the reader reads neither the cache-tree
>> nor the resolve undo data, however, it won't choke on an
>> index that includes such data.
>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Helped-by: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
>> Helped-by: Thomas Rast <trast@student.ethz.ch>
>> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>> ---
>> [...]
>> +static struct directory_entry *read_directories(unsigned int *dir_offset,
>> +                                               unsigned int *dir_table_offset,
>> +                                               void *mmap, int mmap_size)
>
> Minor nit: why is this mmap_size "int" while all others are "unsigned long" ?

Thanks for catching that.  It should be "unsigned long" here to.  Will
fix in the re-roll.

>> [...]
>> +static int read_entry(struct cache_entry **ce, char *pathname, size_t pathlen,
>> +                     void *mmap, unsigned long mmap_size,
>> +                     unsigned int first_entry_offset,
>> +                     unsigned int foffsetblock)
>> [...]
>> +static int read_entries(struct index_state *istate, struct directory_entry *de,
>> +                       unsigned int first_entry_offset, void *mmap,
>> +                       unsigned long mmap_size, unsigned int *nr,
>> +                       unsigned int foffsetblock)
>> [...]
>> +static int read_index_v5(struct index_state *istate, void *mmap,
>> +                        unsigned long mmap_size, struct filter_opts *opts)
