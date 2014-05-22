From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 32/44] refs.c: remove the update_ref_write function
Date: Thu, 22 May 2014 09:49:43 -0700
Message-ID: <CAL=YDW=g=5ux4tThcK3EEmPuzqmwGBX+7au4MMWnfL_NLq897A@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-33-git-send-email-sahlberg@google.com>
	<20140521220710.GG12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 18:49:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnWBl-0006ix-20
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 18:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbaEVQtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 12:49:46 -0400
Received: from mail-ve0-f178.google.com ([209.85.128.178]:64618 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbaEVQto (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 12:49:44 -0400
Received: by mail-ve0-f178.google.com with SMTP id sa20so4738073veb.23
        for <git@vger.kernel.org>; Thu, 22 May 2014 09:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QUoVURmHyRrTZDvAi4lww4pVHSibH7KIDvt2GuRUKFQ=;
        b=kgZvMHQ0b9PW406ChdpxNgR4xRdU8IQRxzZwE5uMz8O++ez/gjJzKgoLlchLG7n+3a
         jsNRlSq68TTj6Na7GDWjU7oJL2UdUNv9EzHvgBK9DciCdHnZwRIuf8hUijAaxe8B/t/o
         VHz/gE8nembxv9C2ES7JQvVlXvZIiTJocXNIszidtasAVDXRJkTWLjZMV3YS13PWxwuI
         c+MZxDu45xp5V+nNIRN2VAnzKhYdb0HumHtmUmGpmkYzcyttOF6cjgz9rnjM499grj0n
         k8Sf3EUmTm4gVjV7G0kC0kctn7q6u2jEIUn9bWaIapm9m//8sKQeywRMhZtjY5CzEI/M
         oPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=QUoVURmHyRrTZDvAi4lww4pVHSibH7KIDvt2GuRUKFQ=;
        b=ReJwT+xeQf4It67/glIAaFgOno0DiD8tIQrSrQvw0cTjqvMLDhkLFmUAmxHfvLRcI0
         3r5eZAt2eXXn7/08aAFA4po7NnwbYTOEFzMEI6a/oGxSx+wUTUODijXWu1GV4wH6BdMg
         J0+uXd/wIq8vMIn/7P182wdk9woCoXagjpUP8eGtmDc1aaOXM18JUUzyOoMVQCYzgFpg
         0aKISC4eWWZSrdKFUYWBbGaXCdWQSoHpvFGAW9t8dwZHuYc2px38wWwPM0gQI2Z3dr/Y
         T1F8ZZ/z/UiuYKu0sKWhEv298tqw5SIQiKCg/1VOwcqDvVEdLVAl6yOARFGBac7paIiD
         Q7kA==
X-Gm-Message-State: ALoCoQlt8tDfLN5Osc/Rlq+eXquNpaOEzmIWaBAL2wFx9LmVBOHtaDk/n0XLPLNe76wsn4XHAicV
X-Received: by 10.53.13.35 with SMTP id ev3mr3657167vdd.1.1400777383752; Thu,
 22 May 2014 09:49:43 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 22 May 2014 09:49:43 -0700 (PDT)
In-Reply-To: <20140521220710.GG12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249917>

On Wed, May 21, 2014 at 3:07 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> +++ b/refs.c
> [...]
>> @@ -3518,14 +3499,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>>               struct ref_update *update = updates[i];
>>
>>               if (!is_null_sha1(update->new_sha1)) {
>> -                     ret = update_ref_write(msg,
>> -                                            update->refname,
>> -                                            update->new_sha1,
>> -                                            update->lock, err,
>> -                                            UPDATE_REFS_QUIET_ON_ERR);
>> +                     ret = write_ref_sha1(update->lock, update->new_sha1,
>> +                                          msg);
>
> This changes the return value on error from 1 to -1.  That seems like a
> good change.  It's probably worth mentioning in the commit message.

Done.
