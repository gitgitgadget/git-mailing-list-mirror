From: "Torne (Richard Coles)" <torne@google.com>
Subject: git grep -F doesn't behave like grep -F?
Date: Fri, 18 May 2012 12:00:17 +0100
Message-ID: <CAEV-rjc0PtuQZei95_24=Ou=mZZxA0Lsr6boXGrGy3z40otkNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 13:00:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVKvO-00055C-21
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 13:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827Ab2ERLAX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 07:00:23 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43128 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718Ab2ERLAS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2012 07:00:18 -0400
Received: by yenm10 with SMTP id m10so2662209yen.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 04:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding:x-system-of-record;
        bh=nAaLsYRFSjb+OYIQna67NIRy3X0uiT5DOOq/I62xv68=;
        b=XNtK+WB4QZTC7NzSj2AuT8dhG8J98hCr+idUXMwwQgSuKM2fmfSj7od9C2Q2r/7362
         K7VwgODuh/bVO+2GGq0v4N2KIKu6SfcfzponA5zlprfrZtp0D8WWS6rDRPKf3PlIDU4z
         LNsGsJPf0HOJGAYBpaHYbNwdH78qcydtAYYAoBjyELEh4pfwzc7ZQ8XPFaGWNZ3ZVmoh
         tjyJjR4llCDSxTDmGNZFKAe8KmormzgnMozWVpGjHNj8w3TREQoj5O3bPjixSCSNzd2O
         LzFI5tKoubMOiBYnPgjgspXXMVzsQBI75PnpYYBQc2aiEnDRTTE7vtNUE54gu5ireL3f
         FCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding:x-system-of-record:x-gm-message-state;
        bh=nAaLsYRFSjb+OYIQna67NIRy3X0uiT5DOOq/I62xv68=;
        b=mVSFRq5LzPcs6lotSf0KlFWA/JVlt0tnqBiPFp5H4u6zI11ilK59qfSv3Eg76Z1GL3
         3zflaPA81X+Qj8amzxSlFPda/Rg3SPKeCxTxq/0Srou1iRVH8cWZpdqoEa7Pk4szfOFU
         dKtBP8DqqS2/Lc+bDDB1RF2UvJFP5VaxPK5VO2zplY1YDQA8976siQP0hmI1GgZmzTNH
         NYFyuUGkUs4Bepsj6wIOYmzyC+nT8UsfnA94oXC5BhwUSFBzrOo8xoXcpi7Rc21zojXx
         JDVhL2yRO0f2Z+YJVX6OOSedr94j0/N2rySbRPkHqE7VklNUiCe5Bu44SOPmrCCg5FL+
         iyOg==
Received: by 10.42.77.69 with SMTP id h5mr6678248ick.44.1337338817259;
        Fri, 18 May 2012 04:00:17 -0700 (PDT)
Received: by 10.42.77.69 with SMTP id h5mr6678242ick.44.1337338817115; Fri, 18
 May 2012 04:00:17 -0700 (PDT)
Received: by 10.231.111.131 with HTTP; Fri, 18 May 2012 04:00:17 -0700 (PDT)
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQn33dMynqZ/0KoTNlRg3iCgbNedMl+I15Y/RGReY+Bq6Hao5wfW3qEtZL+hAq/IkOmKbtc1qTnl2F+jl1ZERuW0G4d5yxknnfI/zMmTOquMGnLPlcVwnQwZisW9nhufFljYD4bIJJ5uHg3Cro1+BuLdLQjTFA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197947>

Hi folks,

git grep -F is documented as: "Use fixed strings for patterns (don=92t
interpret pattern as a regex)."

whereas grep -F is documented as "Interpret PATTERN as a  list  of
fixed  strings,  separated  by newlines,  any  of  which is to be
matched."

This accurately describes how they behave, which means that git grep
-F with a pattern containing newlines never matches anything (at least
as far as I can see). Is this intentional, or an oversight? The
ability to grep -F for a list (e.g. the output of another grep) is
pretty handy...

--=20
Torne (Richard Coles)
torne@google.com
