From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/7] Modify fast-export testcase to check that we 
	correctly omit tags of trees
Date: Mon, 22 Jun 2009 07:12:03 -0600
Message-ID: <51419b2c0906220612l5ce0ee4fs6466bb13b001872f@mail.gmail.com>
References: <1245472623-28103-1-git-send-email-newren@gmail.com>
	 <1245472623-28103-3-git-send-email-newren@gmail.com>
	 <200906210817.51520.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	kusmabite@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 15:12:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIjK0-0005of-D5
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 15:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbZFVNMD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2009 09:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755080AbZFVNMC
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 09:12:02 -0400
Received: from mail-qy0-f171.google.com ([209.85.221.171]:45870 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754654AbZFVNMB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2009 09:12:01 -0400
Received: by qyk1 with SMTP id 1so984420qyk.33
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 06:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oIkx6gzjfaRaL1y4VkAYlriSLmWhvInQ6WYZzZT9hf8=;
        b=L/Kmg6eme0wAnj+HFAe+wI/qSKEDElgHsTyx4qvU7kKtw3LPpmPXxmSn+K+BgiFWKg
         auui/MpgBYSjIWYg5Dxq7iKlGYv+MR1b3DY2PWELzpOryZZOa8fc+ZqJmwBrcW63b4KH
         anfzCb2Zkj0HQQ6PwQbNjgBEbLCLhvVVKetHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=P5d3mEBwx92FOsFSyKPca8xF/a3t7s4ZbDF5dLZTiY702Z2IV3KChg3jJxmpSSyuyO
         RvUgFVWoOIB4SXjsQcqQs4qADuvmHBrKa7DlL0v6VdeN4/jqg6ZoqeGfQGn/hgqqHW4O
         2kKNYCYpOfkjn/xvY54JbovMP24VuoOSQIxsM=
Received: by 10.229.80.18 with SMTP id r18mr1071120qck.73.1245676323207; Mon, 
	22 Jun 2009 06:12:03 -0700 (PDT)
In-Reply-To: <200906210817.51520.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122042>

On Sun, Jun 21, 2009 at 12:17 AM, Johannes Sixt<j6t@kdbg.org> wrote:
> On Samstag, 20. Juni 2009, newren@gmail.com wrote:
>> -test_expect_success 'tree_tag' =C2=A0 =C2=A0 =C2=A0 =C2=A0'git fast=
-export tree_tag'
>> +test_expect_success 'tree_tag' =C2=A0 =C2=A0 =C2=A0 =C2=A0'
>> + =C2=A0 =C2=A0 mkdir result &&
>> + =C2=A0 =C2=A0 cd result &&
>> + =C2=A0 =C2=A0 git init &&
>> + =C2=A0 =C2=A0 cd ..
>> + =C2=A0 =C2=A0 git fast-export tree_tag | (cd result && git fast-im=
port)
>> +'
>
> You should make this
>
> test_expect_success 'tree_tag' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mkdir result &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(cd result && git init) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git fast-export tree_tag > fe-stream &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(cd result && git fast-import < fe-stream)
> '
>
> in order to (1) not remain in the wrong directory if git init fails, =
and (2)
> to catch failures in git fast-export.

Thanks for the tips; I've sent a new patch series with these changes
(except that the second fe-stream needs a ../ in front of it), as well
as the changes suggested by Stephen Boyd in the other email in this
thread.

Elijah
