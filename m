From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 5/8] branch: drop non-commit error reporting
Date: Thu, 24 Sep 2015 11:49:34 +0530
Message-ID: <CAOLa=ZTJJF1U0Qmfs3hs2Y0MGnNO17ADadYCnJWCL9D7Y6RVzA@mail.gmail.com>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
 <1443031873-25280-6-git-send-email-Karthik.188@gmail.com> <vpqtwqlt13d.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 24 08:20:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zezt5-0007Pw-ER
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 08:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406AbbIXGUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 02:20:06 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33247 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbbIXGUE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 02:20:04 -0400
Received: by ykft14 with SMTP id t14so65308024ykf.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 23:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fn7nHJN3jbOAIpFlG2RhAyNP1ochsM33rCgGdnys+jE=;
        b=FQ+8yYTIIrh62Sfzqe+4HaRZ+fk9MJ9AxTK2QxrljzcMC87OPQy5+63fTnsn91VLVs
         es74b+Il7dAC+WIYgk5uyTcG+cgBp+averyg53p/BRLzmkvv2Pevvb6Bn6acAoFuI7Tv
         6R78vWkIWfX+RiCqmleQOZKZezGlc60L+6OMNjMk00vSLmWELHbqG9S7CTqESf03O06u
         Ko9xklak67ObZvmCnvPHODsOuhmnzK+EPyAHMLxfQNRwOu9IpdHJnejPY4K+9OCILdOP
         zNPNbJE6mOHA186g25Fyh8ytwVTLc/j18VP08makTn5G5F7RJSJR9EF3Le7epZI00/qL
         DtKg==
X-Received: by 10.31.32.137 with SMTP id g131mr24365482vkg.2.1443075603903;
 Wed, 23 Sep 2015 23:20:03 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Wed, 23 Sep 2015 23:19:34 -0700 (PDT)
In-Reply-To: <vpqtwqlt13d.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278534>

On Thu, Sep 24, 2015 at 12:27 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Remove the error reporting variable to make the code easier to port
>> over to using ref-filter APIs.
>>
>> This also removes the error from being displayed. As branch.c will use
>> ref-filter APIs in the following patches, the error checking becomes
>> redundant with the error reporting system found in the ref-filter
>> (ref-filter.c:1336).
>
> I would have written
>
> As branch.c will use ref-filter APIs in the following patches, the error
> checking becomes redundant with the error reporting system found in the
> ref-filter: error "branch '%s' does not point at a commit" is redundant
> with the check performed in ref_filter_handler (ref-filter.c:1336).
> Error "some refs could not be read" can only be triggered as a
> consequence of the first one hence becomes useless.

This looks better thanks.

>
>> @@ -370,10 +369,8 @@ static int append_ref(const char *refname, const struct object_id *oid, int flag
>>       commit = NULL;
>>       if (ref_list->verbose || ref_list->with_commit || merge_filter != NO_FILTER) {
>>               commit = lookup_commit_reference_gently(oid->hash, 1);
>> -             if (!commit) {
>> -                     cb->ret = error(_("branch '%s' does not point at a commit"), refname);
>> +             if (!commit)
>>                       return 0;
>> -             }
>
> Am I correct that the "return 0" statement above is dead code after the
> end of the series?
>
> If so, you should add a comment explaining that it's there "just in
> case" but not supposed to happen, or replace the if statement with
> "assert(commit);" IMHO. I have a preference for assert(): I don't like
> silent failures.

This code is removed by the end of the series. We could use an assert()
in this patch, but I don't see the point, its removed later either ways when
we use ref-filter APIs.

-- 
Regards,
Karthik Nayak
