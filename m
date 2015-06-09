From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 3/9] for-each-ref: add '--points-at' option
Date: Tue, 09 Jun 2015 12:07:26 -0700
Message-ID: <xmqqvbew66q9.fsf@gitster.dls.corp.google.com>
References: <5573520A.90603@gmail.com>
	<1433621052-5588-1-git-send-email-karthik.188@gmail.com>
	<1433621052-5588-3-git-send-email-karthik.188@gmail.com>
	<xmqqzj4a9fpn.fsf@gitster.dls.corp.google.com>
	<5576D591.6030704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 21:07:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Os4-0007cN-13
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 21:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935AbbFITHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 15:07:32 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:32798 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911AbbFITHa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 15:07:30 -0400
X-Greylist: delayed 1174 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jun 2015 15:07:30 EDT
Received: by igdj8 with SMTP id j8so3076225igd.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 12:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NnyZ9ekBA6fCGMgpKdMxhPb/NS5EXHjVPUN95ZVvkKs=;
        b=NisS8/43kwhJsmzwyuZfa+AXRWfriAxRNMKcAQKOEHdz1gjHOi0Zp1kF6YmOWBlFc7
         jSxG/6sXRqGOPDtYjvabmP30jE1x+swAF4D0E4L5urLlY8XdHh/Wc/SvEbKXAdjV1waT
         L/IPGsHBu6obLfK/eM/PBWDwl/q39clhbx6g2bc3ADntWLNWTm0ZROdcQ/t7wVULICA9
         pW+3vtWfYMj1LmRYI2nEK4+JcYw9E3HA1ykeB6xTN7isnDKYmvAp9M+mWHVpuFC1j2yw
         p6J8bRkjlBnQ5vK5pGii1mcUElVllIpYrvX2yKjZSgLbEws77wZ5DGTEzFS7iBjK3aY3
         MX4w==
X-Received: by 10.50.225.35 with SMTP id rh3mr22136500igc.29.1433876848434;
        Tue, 09 Jun 2015 12:07:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id a2sm1715337igx.3.2015.06.09.12.07.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jun 2015 12:07:27 -0700 (PDT)
In-Reply-To: <5576D591.6030704@gmail.com> (Karthik Nayak's message of "Tue, 09
	Jun 2015 17:31:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271232>

Karthik Nayak <karthik.188@gmail.com> writes:

>>> @@ -54,7 +59,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>>>   	/* for warn_ambiguous_refs */
>>>   	git_config(git_default_config, NULL);
>>>
>>> -	memset(&ref_cbdata, 0, sizeof(ref_cbdata));
>>
>> I cannot quite see how this change relates to the addition of the
>> new option.
>>
>
> Well if we memset() after calling parse_opt_points_at(), we loose all
> the information we would have obtained.
> So the memset() is moved to an earlier location.

which I did not see, because I expected the code to follow the usual
"no decl-after-statement" pattern.  IOW

>>   	int maxcount = 0, quote_style = 0;
>>   	struct ref_filter_cbdata ref_cbdata;
>> +	memset(&ref_cbdata, 0, sizeof(ref_cbdata));
>>
>>   	struct option opts[] = {
>>   		OPT_BIT('s', "shell", &quote_style,

Don't do that.  Always start your function like so:

	type funcname(args)
        {
        	declarations;

                first statement;
		...

with no blank line within declarations block and a blank line after
the declarations block.
