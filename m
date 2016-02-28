From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/7] replacing strbuf_getline_lf() by strbuf_getline()
Date: Sun, 28 Feb 2016 01:30:01 -0500
Message-ID: <CAPig+cSv=7zixz_BK=f0MhQnTTB-agB5=4aSrFE5vAJtOgbuGg@mail.gmail.com>
References: <56CA5DBB.8040006@moritzneeb.de>
	<56D28092.9090209@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Sun Feb 28 07:30:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZurp-0005EI-Q5
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 07:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbcB1GaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 01:30:04 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35722 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbcB1GaD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 01:30:03 -0500
Received: by mail-vk0-f68.google.com with SMTP id e185so7491897vkb.2
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 22:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=ApA5zEPzG587s/Tcp/qnBiwRT84Pp9S8+eDPz1O5524=;
        b=EEyS7OT+KcWOZTuYXM0jBppbp8mtJt519uTc1XYljmnTpzpXCZJagPkmEtEEPLvplu
         qKiA05xJmlrgc5GbpZOd9JLQSHC6xYu90n7iOjI+PltxA8VHXng1hngYcfi19hWINj46
         obYxNNyX2qLlh6A6nJLH4yXV1hDZtHpM9zVw2BihaBky0tNy1O6EG1ATuy5mrdmZM5V2
         2rhbFYoRrwMq1JRuBkGGPXKPlLY9Y+PKsREXjBznY0vj/hxJ7n5BkxASxvCcEs4Nf0mG
         7PeLkbXq0qr1Rkoee5eKWJqiQdvJW+R61olmI8RbOVz1QD+mnHL9GcYOUicu/QRa0S2/
         evow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ApA5zEPzG587s/Tcp/qnBiwRT84Pp9S8+eDPz1O5524=;
        b=CdQCnj7dYcJkvBIEeGRnCtraP8QCkOMPimEEikD3kZRCq1elTDPZczXjd6BfDxD2io
         BvZthH/0Ja9YBxkyXM6QIjgy5Jkrx4dq4+5cUcdSTl3ZKwLrVM/S8+okPm/QyEqvktd9
         sZgCs0JYCtSmreOLM3rdevRID8IvQlEbKAEbslBT6WmhEheHvLY1GmXmnSRd+pg4NKSl
         zX7PjSz99r/KNp9g9wkYcCuiDRg+mSN5QKijCb2B+73WTAlakXadJBlF+jJ9tGRMNmJ7
         rrqR5iZn4dHL1K/wedgUK4i1GbFEQjM+jrZmUSCM0/SO96Z2HZxdgO+fZ3QpSjmgqhgN
         0xJQ==
X-Gm-Message-State: AD7BkJJyemj6LDGruUbORsaEflVVSCFTL2ioe7zUctsJZg33lE29OL8zsN243qw+JMth4UfB34N2hAApdd2AAQ==
X-Received: by 10.31.168.76 with SMTP id r73mr7098693vke.117.1456641001297;
 Sat, 27 Feb 2016 22:30:01 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 27 Feb 2016 22:30:01 -0800 (PST)
In-Reply-To: <56D28092.9090209@moritzneeb.de>
X-Google-Sender-Auth: D4ecD01qOnDHqI_Cn16JQ4kJTzo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287751>

On Sun, Feb 28, 2016 at 12:07 AM, Moritz Neeb <lists@moritzneeb.de> wrote:
> This series deals with strbuf_getline_lf() in certain codepaths:
> Those, where the input that is read, is/was trimmed before doing anything that
> could possibly expect a CR character. Those places can be assumed to be "text"
> input, where a CR never would be a meaningful control character.
> [...]
>
> Changes since v2:
>
> * Line splitting in notes_copy_from_stdin() is changed to string_list_split as
>   suggested by Eric Sunshine.
> * The behavior change in interactive cleaning from patch v2 is undone.
> * Some of the previous patches were broken because of some unexpected
>   whitespace. This should be fixed now.

In the future, as an aid to reviewers, please include an interdiff
since the previous version, as well a link to the previous round[1].
It's also very helpful to say which patches have changed (and which
have not).

Thanks.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/285118/focus=286865
