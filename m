From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v7 6/7] git-p4: add support for large file systems
Date: Fri, 25 Sep 2015 10:09:46 +0100
Message-ID: <CAE5ih7890uN-5uP9YkwqGi8AV2P+s=Heban6fvbdJ4DG-WrurA@mail.gmail.com>
References: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
	<1442875273-48610-7-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 11:09:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfP0t-00050A-Cd
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 11:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490AbbIYJJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 05:09:51 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33970 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622AbbIYJJt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 05:09:49 -0400
Received: by oiev17 with SMTP id v17so55111280oie.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 02:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JNQs40wp8QAGfobkDDoy2wKVwkvRJe9iIYI9Qg2eV3k=;
        b=Hy9Z2R3/s1qQbGDCKxS1vnbM2gfjXs/y9fh8cxK84nvSDQ1EhxLLygeN53c+0jSTpH
         NcZYzPbkQ2QNMPmlUlf0K/gG4gLlVYLxylzeq1UVrH6QRspkwRWejqcgEw03TcWmA/PJ
         T8zuMxKZcYaHRqoxm36bWFnJmtVFmVQrfk/Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=JNQs40wp8QAGfobkDDoy2wKVwkvRJe9iIYI9Qg2eV3k=;
        b=eOaNH6+AiBFV0lfaBAT2EoxbP9/v3wyqviVztdI3OXLBIqyGmCO5GlAkGniy/yXECp
         jcWKGfyQxKe9HPtakxibTvfw4XOdGWr09qcmSwCFTFozwDMra/Pqw/IrerqCtyr99+dx
         bIn569xj5ErmCtdmlB+EFFERKQzSj5o58zsT3uv+JuCoIIwPszTGPvLQodiVZAdEEPFx
         Dlk+ilwXhjj/83vXKFKt8VT+e1DF+sxJ+7od8x+KkhyUSWBHYQHG750F7zxEB/OLTp5L
         aJNmbWfEoh2N8j3XUHnufBliyE6D6jedlmCg9grbm2559ZIRgiju1oWdFxgEyKxRgqvG
         wFJA==
X-Gm-Message-State: ALoCoQkYnSGYl4JedaY1q5ME0DKiqeFhT9F2kw1SHsgtmAKKRRsCmK0Pa33NwqRbz1oyLVGi847W
X-Received: by 10.202.175.88 with SMTP id y85mr2385968oie.22.1443172186346;
 Fri, 25 Sep 2015 02:09:46 -0700 (PDT)
Received: by 10.60.46.38 with HTTP; Fri, 25 Sep 2015 02:09:46 -0700 (PDT)
In-Reply-To: <1442875273-48610-7-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278654>

One tiny comment, otherwise this looks good to me.

Can we use test_path_is_missing in place of !test_path_is_file ?



On 21 September 2015 at 23:41,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> Perforce repositories can contain large (binary) files. Migrating these
> repositories to Git generates very large local clones. External storage
> systems such as Git LFS [1], Git Fat [2], Git Media [3], git-annex [4]
> try to address this problem.
>
> Add a generic mechanism to detect large files based on extension,
> uncompressed size, and/or compressed size.
>
> [1] https://git-lfs.github.com/
> [2] https://github.com/jedbrown/git-fat
> [3] https://github.com/alebedev/git-media
> [4] https://git-annex.branchable.com/
>
>
> diff --git a/t/t9823-git-p4-mock-lfs.sh b/t/t9823-git-p4-mock-lfs.sh
> new file mode 100755
> index 0000000..5684ee3
> --- /dev/null
> +++ b/t/t9823-git-p4-mock-lfs.sh
> @@ -0,0 +1,170 @@
> +#!/bin/sh
> +
> +test_description='Clone repositories and store files in Mock LFS'
> +
> +. ./lib-git-p4.sh
> +
> +test_file_is_not_in_mock_lfs () {
> +       FILE="$1" &&
> +       CONTENT="$2" &&
> +       echo "$CONTENT" >expect_content &&
> +       test_path_is_file "$FILE" &&
> +       test_cmp expect_content "$FILE"
> +}
> +
> +test_file_is_in_mock_lfs () {
> +       FILE="$1" &&
> +       CONTENT="$2" &&
> +       LOCAL_STORAGE=".git/mock-storage/local/$CONTENT" &&
> +       SERVER_STORAGE=".git/mock-storage/remote/$CONTENT" &&
> +       echo "pointer-$CONTENT" >expect_pointer &&
> +       echo "$CONTENT" >expect_content &&
> +       test_path_is_file "$FILE" &&
> +       test_path_is_file "$LOCAL_STORAGE" &&
> +       test_path_is_file "$SERVER_STORAGE" &&
> +       test_cmp expect_pointer "$FILE" &&
> +       test_cmp expect_content "$LOCAL_STORAGE" &&
> +       test_cmp expect_content "$SERVER_STORAGE"
> +}
> +
> +test_file_is_deleted_in_mock_lfs () {
> +       FILE="$1" &&
> +       CONTENT="$2" &&
> +       LOCAL_STORAGE=".git/mock-storage/local/$CONTENT" &&
> +       SERVER_STORAGE=".git/mock-storage/remote/$CONTENT" &&
> +       echo "pointer-$CONTENT" >expect_pointer &&
> +       echo "$CONTENT" >expect_content &&
> +       ! test_path_is_file "$FILE" &&

Perhaps use test_path_is_missing instead here?

> +       test_path_is_file "$LOCAL_STORAGE" &&
> +       test_path_is_file "$SERVER_STORAGE" &&
> +       test_cmp expect_content "$LOCAL_STORAGE" &&
> +       test_cmp expect_content "$SERVER_STORAGE"
> +}
> +
> +test_file_count_in_dir () {
> +       DIR="$1" &&
> +       EXPECTED_COUNT="$2" &&
> +       find "$DIR" -type f >actual &&
> +       test_line_count = $EXPECTED_COUNT actual
> +}
> +
> +test_expect_success 'start p4d' '
> +       start_p4d
> +'
> +
> +test_expect_success 'Create repo with binary files' '
> +       client_view "//depot/... //client/..." &&
> +       (
> +               cd "$cli" &&
> +
> +               echo "content 1 txt 23 bytes" >file1.txt &&
> +               p4 add file1.txt &&
> +               echo "content 2-3 bin 25 bytes" >file2.dat &&
> +               p4 add file2.dat &&
> +               p4 submit -d "Add text and binary file" &&
> +
> +               mkdir "path with spaces" &&
> +               echo "content 2-3 bin 25 bytes" >"path with spaces/file3.bin" &&
> +               p4 add "path with spaces/file3.bin" &&
> +               p4 submit -d "Add another binary file with same content and spaces in path" &&
> +
> +               echo "content 4 bin 26 bytes XX" >file4.bin &&
> +               p4 add file4.bin &&
> +               p4 submit -d "Add another binary file with different content"
> +       )
> +'
> +
> +test_expect_success 'Store files in Mock LFS based on size (>24 bytes)' '
> +       client_view "//depot/... //client/..." &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +               git init . &&
> +               git config git-p4.useClientSpec true &&
> +               git config git-p4.largeFileSystem MockLFS &&
> +               git config git-p4.largeFileThreshold 24 &&
> +               git config git-p4.pushLargeFiles True &&
> +               git p4 clone --destination="$git" //depot@all &&
> +
> +               test_file_is_not_in_mock_lfs file1.txt "content 1 txt 23 bytes" &&
> +               test_file_is_in_mock_lfs file2.dat "content 2-3 bin 25 bytes" &&
> +               test_file_is_in_mock_lfs "path with spaces/file3.bin" "content 2-3 bin 25 bytes" &&
> +               test_file_is_in_mock_lfs file4.bin "content 4 bin 26 bytes XX" &&
> +
> +               test_file_count_in_dir ".git/mock-storage/local" 2 &&
> +               test_file_count_in_dir ".git/mock-storage/remote" 2
> +       )
> +'
> +
> +test_expect_success 'Store files in Mock LFS based on extension (dat)' '
> +       client_view "//depot/... //client/..." &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +               git init . &&
> +               git config git-p4.useClientSpec true &&
> +               git config git-p4.largeFileSystem MockLFS &&
> +               git config git-p4.largeFileExtensions dat &&
> +               git config git-p4.pushLargeFiles True &&
> +               git p4 clone --destination="$git" //depot@all &&
> +
> +               test_file_is_not_in_mock_lfs file1.txt "content 1 txt 23 bytes" &&
> +               test_file_is_in_mock_lfs file2.dat "content 2-3 bin 25 bytes" &&
> +               test_file_is_not_in_mock_lfs "path with spaces/file3.bin" "content 2-3 bin 25 bytes" &&
> +               test_file_is_not_in_mock_lfs file4.bin "content 4 bin 26 bytes XX" &&
> +
> +               test_file_count_in_dir ".git/mock-storage/local" 1 &&
> +               test_file_count_in_dir ".git/mock-storage/remote" 1
> +       )
> +'
> +
> +test_expect_success 'Remove file from repo and store files in Mock LFS based on size (>24 bytes)' '
> +       client_view "//depot/... //client/..." &&
> +       (
> +               cd "$cli" &&
> +               p4 delete file4.bin &&
> +               p4 submit -d "Remove file"
> +       ) &&
> +
> +       client_view "//depot/... //client/..." &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +               git init . &&
> +               git config git-p4.useClientSpec true &&
> +               git config git-p4.largeFileSystem MockLFS &&
> +               git config git-p4.largeFileThreshold 24 &&
> +               git config git-p4.pushLargeFiles True &&
> +               git p4 clone --destination="$git" //depot@all &&
> +
> +               test_file_is_not_in_mock_lfs file1.txt "content 1 txt 23 bytes" &&
> +               test_file_is_in_mock_lfs file2.dat "content 2-3 bin 25 bytes" &&
> +               test_file_is_in_mock_lfs "path with spaces/file3.bin" "content 2-3 bin 25 bytes" &&
> +               test_file_is_deleted_in_mock_lfs file4.bin "content 4 bin 26 bytes XX" &&
> +
> +               test_file_count_in_dir ".git/mock-storage/local" 2 &&
> +               test_file_count_in_dir ".git/mock-storage/remote" 2
> +       )
> +'
> +
> +test_expect_success 'Run git p4 submit in repo configured with large file system' '
> +       client_view "//depot/... //client/..." &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +               git init . &&
> +               git config git-p4.useClientSpec true &&
> +               git config git-p4.largeFileSystem MockLFS &&
> +               git config git-p4.largeFileThreshold 24 &&
> +               git config git-p4.pushLargeFiles True &&
> +               git p4 clone --destination="$git" //depot@all &&
> +
> +               test_must_fail git p4 submit
> +       )
> +'
> +
> +test_expect_success 'kill p4d' '
> +       kill_p4d
> +'
> +
> +test_done
> --
> 2.5.1
>
