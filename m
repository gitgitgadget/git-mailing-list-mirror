From: Dominique Quatravaux <domq@google.com>
Subject: Re: [PATCHv2 1/2] rebase -i: optimize the creation of the todo file
Date: Fri, 9 Mar 2012 10:52:03 +0100
Message-ID: <CAJh6GrH3x-Fz5gqKdu_fcmH0OH3KG8En3H2vURKhkYuiC+s59g@mail.gmail.com>
References: <1331214777-9455-1-git-send-email-domq@google.com>
 <CAFfmPPMt_o1Rg-Pvuh_KpARrASwfYSq74UN3ayp=LVzLJ0oj=A@mail.gmail.com> <7vpqcm85rs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <davidbarr@google.com>, git@vger.kernel.org,
	Thomas Rast <trast@inf.ethz.ch>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 10:52:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5wUx-0006jF-5J
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 10:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080Ab2CIJw0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Mar 2012 04:52:26 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33135 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab2CIJwZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 04:52:25 -0500
Received: by wgbdr13 with SMTP id dr13so1455384wgb.1
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 01:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=j+5YgnrylEPOVFXiPPtf3NHNrMtzA5dnRB/zHnNnXeE=;
        b=ZbmMas9D1nB7cE0UvuFTckUw6ftne8WyxVvlgVaceZWX7NfAdnjaCmAfV+SfxZzIXH
         88ZO7eLUV6Ec1AA6alf0fUDZf31cMdlqdO7w1ahYJC/nGICwLqzxFjZuMQwf8x8Vuqw6
         j6ksmJV8124CLhV21tkwagm+qp/anMr9O0CRT4jRN9ZyEEBypS3XmrMrhgZwNBM9zTYV
         sd0+pw0XdJBiQJLL/rnLXncn+/z6CKy5EfHkChUP1TZSh3dR7DN07UYiCc8GQBAp7z+i
         YNVaA6O1ZD2a0QjN4KOt3yYZdYTzc0blblc7L/OXpy5VwGODzWlY8HIXKuiTD6K12vdb
         a9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=j+5YgnrylEPOVFXiPPtf3NHNrMtzA5dnRB/zHnNnXeE=;
        b=lZx6/uMhaldOFj8NYb0sE5F/BgUX49qLWJaP0VZrK3nJGl/pUGV/52yATi76ss+JEv
         SXnvbdZNM+mO7F/npgw31eisgJC7gmgqlBr8Clljc3jzf5xj9nku7J9cOpgpeAgWXNtz
         nTuLL8DDxcMMsCUKF3nbo+x5tjIaxgWsPQ8iS2IZ61juuFhqxfX0vMthDqIbO60dx47O
         wgw9LK8/WCkbcZtJGXFWR0lvyek65KKuyVzRZWMHav6SMxYwabuk11IObGRJomGr9JgY
         htkZPE+n8bH1o7B1sNj05USkN/vj+UwGdVyfenZVo4ZStTxeUKxLFjnHtmFwjzn2llWa
         eSqw==
Received: by 10.216.82.141 with SMTP id o13mr1070169wee.2.1331286744256;
        Fri, 09 Mar 2012 01:52:24 -0800 (PST)
Received: by 10.216.82.141 with SMTP id o13mr1070157wee.2.1331286744083; Fri,
 09 Mar 2012 01:52:24 -0800 (PST)
Received: by 10.227.7.138 with HTTP; Fri, 9 Mar 2012 01:52:03 -0800 (PST)
In-Reply-To: <7vpqcm85rs.fsf@alter.siamese.dyndns.org>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQk/JMh6IaOstcc2EEGSRpidwThzP4qIA5lfzdvqRcg/KltKaLBmfSYftj3vurElgoWRERCQCdHXrxketTciKF2lWFl99p8BiC5CsCH9EUfwM6jmZTHbb6NP7QM2rQuw+P836X84fG+Ko9pRm0VuTlYI9wunsw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192704>

On Fri, Mar 9, 2012 at 10:47 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> David Barr <davidbarr@google.com> writes:
>
>> I do notice however that the output being fed to sed expands like so=
:
>>
>> =A0 commit >634a5f265ad729b91266de65272e2b5a35d05b1c
>> =A0 >634a5f265ad729b91266de65272e2b5a35d05b1c 634a5f2 INSTALL: warn =
[...]
>> =A0 commit >828ea97de486c1693d6e4f2c7347acb50235a85d
>> =A0 >828ea97de486c1693d6e4f2c7347acb50235a85d 828ea97 Git 1.7.9
>>
>> Maybe the format spec and sed command could use a little tuning.
>
> Why would that be a problem, though? =A0The sed script picks only
> lines that begin with '>' and discards the traditional diff-tree
> style per commit header, no?

I assume that David wants to have

  commit >634a5f265ad729b91266de65272e2b5a35d05b1c
  634a5f2 INSTALL: warn [...]

and chew on that with sed.

--=20
=A0 Dominique Quatravaux
=A0 +41 79 609 40 72
