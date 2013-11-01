From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 03/10] transport-helper: add 'force' to 'export' helpers
Date: Fri, 1 Nov 2013 13:28:59 -0400
Message-ID: <CAPig+cSZJoTJbgWHZfoWvtzsePUq=KbNoxapwA+59fnT+KoUPA@mail.gmail.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
	<1383212197-14259-7-git-send-email-felipe.contreras@gmail.com>
	<xmqqa9hp714d.fsf@gitster.dls.corp.google.com>
	<CAMP44s39H8tASO_OvK+C+XSG-2pm09RJY6Xeg4AqDZBAU7GPaw@mail.gmail.com>
	<xmqqfvrh5kev.fsf@gitster.dls.corp.google.com>
	<xmqqppqk2n3d.fsf@gitster.dls.corp.google.com>
	<CAMP44s1wfk3zmiof6E474vNi72zTo_QFj=56G3POjopukGK-5Q@mail.gmail.com>
	<xmqqa9ho2i6v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 01 18:29:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcIWx-0005JD-Jn
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 18:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303Ab3KAR3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 13:29:01 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:46796 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab3KAR3A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 13:29:00 -0400
Received: by mail-la0-f41.google.com with SMTP id el20so3702839lab.0
        for <git@vger.kernel.org>; Fri, 01 Nov 2013 10:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ooNQtWRLWzdyjlCsxzNfYz8JO2Piqc+gITINK/2AbxM=;
        b=n41zJgX1TLAEo3VJi2R1QSkHe8a3U+t+E9ZE8LXqypTbLYp0Z+4ZUq3uQdSmS6Za3g
         XWdaoVvplGpIi1b4SJZLUi2gxy6/cLk9kBQERGB5/UaZ2PEII/f1kuFy27Mx6YbonsjZ
         /98q2Aom/NBJpXqJCsEtYuCwbSA8NPqf92zrFT3KEXg+QdNmJXcYA0kW1kiwp2g7a0sr
         5DtbM/QblTHxqCGQnsHQglVZkiOJD243qXmV7Dr184MxhJkKD6h8x2eOj4kSbjc2PgA7
         hV0iVUT3cJrj43xgP6aZE3zzE31QGuoqSiTOvdtQrqfMEeCwukRIpFINPCmpy4Gcqcr+
         mk1A==
X-Received: by 10.152.9.2 with SMTP id v2mr2049568laa.40.1383326939433; Fri,
 01 Nov 2013 10:28:59 -0700 (PDT)
Received: by 10.114.200.180 with HTTP; Fri, 1 Nov 2013 10:28:59 -0700 (PDT)
In-Reply-To: <xmqqa9ho2i6v.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: tFhTN42cXwvi_Qj-oJa8nLwQPXQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237217>

On Fri, Nov 1, 2013 at 12:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Subject: [PATCH] transport-helper: demote lack of "force" option to a warning
>
> It would have been a good conservative position to take, if there
> were no existing helpers, to die when the user asked to force a push
> through a transport helper mechanism and the helper script hasn't
> been updated to handle the "force" option.
>
> There however are existing helpers in the field and none of them
> obviously has been taught about the option yet.  If a helper has not
> been updated to understand "force", but the user has happily been
> accepting the result of "git push $there +master" (perhaps because
> he has never pushed a non-ff history so far), the change made
> previously in this series will fail the push, which would be a minor
> regression for such a user.
>
> Demote lack of "force" option from a "die()" to a "warning()".  By
> doing so, such a user now gets a warning that notifies him that his
> push has been working by accident, even when the particular ff-push
> that showed the error message goes through successfully.
>
> If his push does need "force", he gets the same old behaviour,
> possibly a broken one, out of the helper that has not been update,

s/update/updated/

> but again he does see the warning.
>
> Helped-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
