From: Stefan Beller <sbeller@google.com>
Subject: Re: arbitrary memory allocation
Date: Mon, 30 Nov 2015 17:03:51 -0800
Message-ID: <CAGZ79kaqSOeK4E6+yKLCP63bK6Fd4XmP=8XcMqMqP_fMLTsbAA@mail.gmail.com>
References: <1a012fc79a55cae8b948b28d1259be0c.squirrel@sdfeu.org>
	<xmqqmvtv6n0b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ytrezq@sdf-eu.org, "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 02:04:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3ZML-0000VK-Uy
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 02:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755454AbbLABDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 20:03:53 -0500
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34206 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305AbbLABDw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 20:03:52 -0500
Received: by ykfs79 with SMTP id s79so208260991ykf.1
        for <git@vger.kernel.org>; Mon, 30 Nov 2015 17:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hkG3JRhiKNg5T+ZXl+fbv+g1bw+zJaaIJPzo96EHOzA=;
        b=hMc7+ozJqUGXEez1jlWZmIVmE7jdxnNpeX4V43hhzzUlvFMNEmUzmiGgLSrcGhGMw2
         1Caik+EkOWoeRKwXgE/+RJmWwESV9YDg2HaefY9iOnJnBZtpXZYM0XCqVFncVb7XUqx+
         r7wq5/wgEkOpsQ9Pe1PhMQA/tEisbvqzCTt5IH25KO/Ypgr18htx2Cib3OI8xgZ5Ta3T
         Ox4o7/+kC1KhF6+tGoQTagMW/WX0GgX5v4P9ydnisAE/PAiMxKROS5z23znaCis5KHAX
         6BLYqmdHl99RqDjS5bXTI8J/rEMRe0rbUUIfidR2WIDfaqu5wLW2FE9xCBlU1h58usNC
         SxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=hkG3JRhiKNg5T+ZXl+fbv+g1bw+zJaaIJPzo96EHOzA=;
        b=j0+aQY7UDNgW366kjg95GLlXmrBPCMQp5nwdLU/H3cJpBOEHmltkBh8umW1kNOnEDz
         E26wtrnlnxBaXJi/r6yzCapqMyC0vOOlg2+dyRcxDobQQY2CSr7/1x65Rm4VxTPcf5u3
         gB2D4n5Nusr1XrryToNojwaElLVN0Xii4RP9p5vjtFdcPtfFERqX/ukOHCI6DFrl6yiT
         pqkiPCUYvdpRlNY6pK9NToOZm0ZTwy60bMRa9M6K3crAbE8AwJDSKYqp6OmgIAhZWlNh
         12v98QtfBPZ/pUTsus09oEkTsEpoH2SM+48q+aWQD81P15JADkXHRtHyf8QCWGoJoOBt
         K0SQ==
X-Gm-Message-State: ALoCoQlUBjAxVQOdWXCX3KZTa1mX3jwLCLyhJGur2rng/hCHHnbzbGLg5QHwRRmPlu5LBd2n5XrG
X-Received: by 10.13.214.19 with SMTP id y19mr56580903ywd.63.1448931831799;
 Mon, 30 Nov 2015 17:03:51 -0800 (PST)
Received: by 10.37.215.16 with HTTP; Mon, 30 Nov 2015 17:03:51 -0800 (PST)
In-Reply-To: <xmqqmvtv6n0b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281829>

On Mon, Nov 30, 2015 at 4:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ytrezq@sdf-eu.org writes:
>
>> line_list="0032want "+obj[1][:40]+'\n'
>> while len(line_list)<65430: # Get the ideal tcp packet size for fastest bandwidth (64Ko)
>>       for i in obj:
>>               if (i==obj[0]) or (i==obj[1]) or ("pull" in i):
>>                       continue
>>               line_list+="0032want "+i[:40]+'\n'
>>               if len(line_list)>65480:
>>                       break
>> ...
>> line_list_len=line_list.count('\n')*56 # Line lengths of the pkt-line format won t fill the ram, so remove them from the size counter
>> count=line_list_len
>> while True:
>>       sys.stdout.flush()
>>       sockobj.send(line_list) # for each line, the git-send-pack process allocate append a member to a struct objects array
>>       print("\r%.2f Mo of ram filled" % float(count/float(1048576))),
>>       count+=line_list_len
>
> This seems to be attempting to throw "want XXXXXXXX" that are
> outside the original server-side advertisement over and over.  Even
> though the set of distinct "want" lines you can throw at the server
> is bounded by the server-side advertisement (i.e. usually you won't
> be able to throw an object name that does not appear at the tip), by
> repeating the requests, you seem to be hoping that you can exhaust
> the object_array() used in upload-pack.c::receive_needs().
>
> But does that attack actually work?  After seeing these "want"
> lines, the object name read from there goes through this code:
>
>                 o = parse_object(sha1_buf);
>                 if (!o)
>                         die("git upload-pack: not our ref %s",
>                             sha1_to_hex(sha1_buf));
>                 if (!(o->flags & WANTED)) {
>                         o->flags |= WANTED;
>                         if (!is_our_ref(o))
>                                 has_non_tip = 1;
>                         add_object_array(o, NULL, &want_obj);

(Looking quickly), I do not see a deduplication in add_object_array,
so you could send the same want line again and again,
to inflate the want_obj array.

If you happen to know a large object in a well known project
(some linux blob maybe?), it would be held a lots of times in memory,
which may trigger the OOM killer in linux?

>                 }
>
> So it appears to me that the requests the code makes in the second
> and subsequent iterations of "while True:" loop would merely be an
> expensive no-op, without bloating memory footprint.
>
> It does waste CPU cycle and network socket, though.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
