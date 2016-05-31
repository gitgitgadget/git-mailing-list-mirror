From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [RFC/PATCH] bisect--helper: `bisect_clean_state` shell function
 in C
Date: Tue, 31 May 2016 12:03:09 +0530
Message-ID: <CAFZEwPOhGuTkZcP+hmnCrNjvHGM_FKUOsQaGwWKoUzokCN5OFg@mail.gmail.com>
References: <20160530182148.18801-1-pranit.bauva@gmail.com>
	<CAP8UFD2wAKN2CsfndLNeCb1dAEH5H-wj_6spAm+d_AtBQDZfhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 08:33:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7dEs-00078E-Py
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 08:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162201AbcEaGdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 02:33:12 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:32950 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755705AbcEaGdK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 02:33:10 -0400
Received: by mail-yw0-f174.google.com with SMTP id h19so179536919ywc.0
        for <git@vger.kernel.org>; Mon, 30 May 2016 23:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=469T+OAdJQB1HLCBjQqonY3ITtxSn3UGY2WE5nwn9Ms=;
        b=bc2iUWGBjOO3gBXU0QQyHWTddTf9i72MRz3OMgvmV1pgKmfzen2b3AMDAtbnsn7H08
         holqZi1ejm2qFa0Bj4VdrCJc9dWu1Fx3fiO+XF6jFv2qQ3+eOyahOwBrGwCDuUBqzzfR
         Hs5Pwj4B55SaySuTq5Pm03vw5JLjLIhrclbdTOl0+LR+82XSRR3IQj2e8ihRMItYciUe
         HU9jZnq8lbxwSkl2zyvXfKYjiKTDL4S3TXVgcmUirGpbt92DQadzd2FYYv/kCMKLIAqO
         kV1PFdTs3lQeteT5Vj2vr7So2rUbjZ40/3pAHYR3zQbnlX2YLcs3bRQFChpOYCMJEJw7
         Wqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=469T+OAdJQB1HLCBjQqonY3ITtxSn3UGY2WE5nwn9Ms=;
        b=DCxxVYtMB6n8z+VZeD97kBZDPUVPW/uewo2qjcjbECtvneIiV+JeelZPVrYa8amZzS
         BK3hhhv1HTts/G34k4chKKGu3ehDbdpbCEYZPGHyWyzCyLcVaafLYd6jz7tNASrGSlcO
         7TmXkEVfv8va7zLGsz3gKbxkJp2EAJLat4E+iO4/QFUz65SkJJubl02/IaZAnGYRL7km
         v5zjtTOOk2hr55HRO5auRTq77lb6tBw0Z0a7dge6nwU5PO2TA9AIzbR1+vEnTEhAPNeB
         KiyHGWVPz73bF6qXy0GznLKB5QSqQZmxZ2tEjByx/VB1ukDx6ir2HPMp6RWCZQcOSXr/
         32Og==
X-Gm-Message-State: ALyK8tIhMEZ98roluHjoIRXO/jeTLv9eAuU9EsUM8njhCg5px8EnGUfAfHo4i/MsFGDLBGc5ipgll5rN6ls3FA==
X-Received: by 10.129.90.135 with SMTP id o129mr20879112ywb.20.1464676389247;
 Mon, 30 May 2016 23:33:09 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Mon, 30 May 2016 23:33:09 -0700 (PDT)
In-Reply-To: <CAP8UFD2wAKN2CsfndLNeCb1dAEH5H-wj_6spAm+d_AtBQDZfhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295956>

Hey Christian,

On Tue, May 31, 2016 at 3:18 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Mon, May 30, 2016 at 8:21 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> ---
>> This patch contains a bug. I have tried to identify the bug and I suppose it
>> exists in do_for_each_entry_in_dir(). I have reproduced the debugging session
>> at this link[1]. I have seen that some patches in mailing list regarding
>> iterating over refs. Will those affect this? Or is this bug fixed in those
>> patches?
>>
>> [1]: http://paste.ubuntu.com/16830752/
>
> The debug session seems to use code source from a previous version of
> this patch.
> Also it is not cear in which context you run git under gdb. What have
> you done before?
> And we don't see a crash. Could you show the crash and run the "bt"
> command in gdb to get a backtrace?

The segmentation fault will occur if I move to the next step ie.
evaluate the value entry->flag.

>> @@ -79,11 +90,42 @@ int write_terms(const char *bad, const char *good)
>>         strbuf_release(&content);
>>         return (res < 0) ? -1 : 0;
>>  }
>> +
>> +int remove_bisect_ref(const char *refname, const struct object_id *oid,
>> +                      int flag, void *cb_data)
>> +{
>> +       char *ref;
>> +       ref = xstrfmt("refs/bisect/%s", refname);
>
> You could save one line by concatenating the 2 above lines.

Sure!

>> +       if (delete_ref(ref, oid->hash, flag))
>> +               return error(_("couldn't delete the ref %s\n"), ref);
>> +       return 0;
>
> You need to free "ref".

Sure!

Regards,
Pranit Bauva
