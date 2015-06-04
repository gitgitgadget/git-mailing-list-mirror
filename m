From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] status: give more information during rebase -i
Date: Thu, 04 Jun 2015 10:19:00 -0700
Message-ID: <xmqqtwunv1bv.fsf@gitster.dls.corp.google.com>
References: <1433368825-24617-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	<1433368825-24617-3-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	<vpqfv67zylq.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Guillaume =?utf-8?Q?Pag=C3=A8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>, git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 04 19:19:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0YnM-0005i2-K6
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 19:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbbFDRTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 13:19:04 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:34242 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294AbbFDRTC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 13:19:02 -0400
Received: by iebmu5 with SMTP id mu5so5810470ieb.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 10:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=dIRvqeaI8Cs/xEp223FF6BBJpj8/v4rZUDgJCJSTAA4=;
        b=XJJHs4bblm5tq6a3Dfw9gMgjtU+rXaLwz7RkqUocSJR859Pkbhs0mDhCOLBIWWR309
         /a53vdtosf4VmuKUI08v9Mcm4R1C+8csh8KEsvdy+1I5qMiR1PHMFYyTpenTFjLpTUAC
         j2qvn2uCNcO61Hy6bA3pVOpwokIseYIyq4RuRSazHiiFuGjPvG4Z7htrqcXJky3EeE1M
         NhLsuPH4PBDgllXxbsyB9obyxrP2pbUaMJkafYifSCaR0hjjRB4fmb3ArS0yhTIq0ZXs
         Vr7FnI7NEVecVY1KORrHHAPKODZUIyTm1sid1U0xhQxX1Db5JmL58VemBUHpOtEKub3K
         qKhg==
X-Received: by 10.50.143.37 with SMTP id sb5mr35346111igb.44.1433438342389;
        Thu, 04 Jun 2015 10:19:02 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:9816:1e41:550:d20e])
        by mx.google.com with ESMTPSA id f82sm1570730iod.44.2015.06.04.10.19.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jun 2015 10:19:01 -0700 (PDT)
In-Reply-To: <vpqfv67zylq.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	04 Jun 2015 10:06:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270785>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> +void get_two_last_lines(char *filename, int *numlines, char **lines)
>> +{
>> +...
>> +}
>> +
>> +void get_two_first_lines(char *filename, int *numlines, char **lines)
>> +{
>> +...
>> +}

I had a handful of comments on these:

 - Do we need two separate and overly specific functions like these,
   i.e. "two" and "first/last"?

 - Wouldn't people want to be able to configure the number of lines?

 - Do we really want get_two_{first,last}_LINES() functions?

   I am wondering if insn sheets these functions read include
   comments, in which case get_n_{first,last}_commands() may be a
   more correct name.

 - Wouldn't it be necessary for these functions to report the total
   number of commands, instead of giving "void" back?  Otherwise how
   would the caller produce summary like this:

       An interactive rebase of 14 commits in progress.  You have
       replayed 4 commits so far, the last few of which were:

          da66b27 remote.c: provide per-branch pushremote name
          f052154 remote.c: hoist branch.*.remote lookup out of

       and 10 more commits to go, the next few of which are:

          a9f9f8c remote.c: introduce branch_get_upstream helper
          8770e6f remote.c: hoist read_config into remote_get_1
       
   Note that I am not suggesting the phrasing or presentation.  The
   information content is what I am interested in.
