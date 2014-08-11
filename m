From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 17/22] refs.c: add a backend method structure with
 transaction functions
Date: Mon, 11 Aug 2014 07:56:35 -0700
Message-ID: <CAL=YDWnbv4XNLny5WTN0b2oKAvDVXAbK536vjRVoTuig98oWFg@mail.gmail.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
	<1407516309-27989-18-git-send-email-sahlberg@google.com>
	<1407521872.26542.21.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 16:56:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGr1c-0000nM-QP
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 16:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbaHKO4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 10:56:36 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:51188 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbaHKO4g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 10:56:36 -0400
Received: by mail-vc0-f179.google.com with SMTP id hq11so11490135vcb.24
        for <git@vger.kernel.org>; Mon, 11 Aug 2014 07:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=28XgMnzvx7psMqr536bFcDL1pGAfsMtL2wId165zWMg=;
        b=P8u7J0RiU7aBvD0qoLmRT1ScFLNLxr0KXzvowLzaVoUTVR9tqqIRStpbXCueCR8AnW
         BeF/YZh+MEZe0x1hoyngDHfExu5eg4iUF4UT40vXkwnSGvKWn7djawmeMsscN756eCo+
         BLxuJfd9sPdZO2c1q0aV44zaFnjx0mfteTOZ3EKkv+3itVH5Dr7k2YWrBWd5hdJHDDDF
         DTOD6/YEQ1zJYNvlOt59xZZXzdhQx1fx4tWYfsfaEy6JZYnJRGL3DU324S3DfDDFp93P
         JQRFs8I99skHpmKeAUFUgamXzVt+s1T8kOFB1Wir+UmsdagZFohmxYxsdpU4/ENs0ne9
         pXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=28XgMnzvx7psMqr536bFcDL1pGAfsMtL2wId165zWMg=;
        b=eZUN6cyMKO4p+B+zu9J+xY0Uatjfi05cu1ZoiR/RCo5qHuUH1PSyj+noYun9egvCPO
         vQQk3KaMr2q+1IxcAuH3FibFeD0qdgVP93BPht7ZS668Fi45toH7jp9vylBwh+CX1k5f
         /AMFxVHW0rkE4jGHSXYZMT6nhhN+6E/OreXZHAeqWHNvXEaMf1jVoEQqe6x2v0uiNvGp
         qqgq2FEeSva+TEefpIGeQ6eVW96NwhEn3VWqYzbHz5U+/T2fFnVaAq6FZ4g5bdmzocOG
         eeHmKcLAxus9haHf5D+yUlUxjjrurQnpL6tiD73MGFo4I+9T5sAr2eNdnkGp+FIU/Rim
         kGSQ==
X-Gm-Message-State: ALoCoQmeKIl/MDGR+ZCHEHboKsLK0Rcd745SmcNmmu9ePi+NrjnnoPaaPeW04gx0TF/9TsugCrJq
X-Received: by 10.52.119.229 with SMTP id kx5mr4977315vdb.40.1407768995125;
 Mon, 11 Aug 2014 07:56:35 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Mon, 11 Aug 2014 07:56:35 -0700 (PDT)
In-Reply-To: <1407521872.26542.21.camel@leckie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255124>

On Fri, Aug 8, 2014 at 11:17 AM, David Turner <dturner@twopensource.com> wrote:
> On Fri, 2014-08-08 at 09:45 -0700, Ronnie Sahlberg wrote:
>
>> +struct ref_be refs_files = {
>> +     .transaction_begin              = files_transaction_begin,
>> +     .transaction_update_sha1        = files_transaction_update_sha1,
>> +     .transaction_create_sha1        = files_transaction_create_sha1,
>> +     .transaction_delete_sha1        = files_transaction_delete_sha1,
>> +     .transaction_update_reflog      = files_transaction_update_reflog,
>> +     .transaction_commit             = files_transaction_commit,
>> +     .transaction_free               = files_transaction_free,
>> +};
>
> C99 designated initializers are unfortunately forbidden by
> CodingGuidelines.
>

Right. Fixed it.

Thanks.
